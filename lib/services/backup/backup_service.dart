import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';

import '../../core/database/app_database.dart';
import 'backup_platform.dart';
import 'backup_platform_types.dart';

class BackupSelection {
  final String path;
  final Map<String, dynamic> data;

  const BackupSelection(this.path, this.data);
}

class BackupService {
  final AppDatabase db;

  BackupService(this.db);

  Future<Map<String, dynamic>> buildBackup() async {
    final students = await db.select(db.students).get();
    final packages = await db.select(db.coursePackages).get();
    final purchases = await db.select(db.purchases).get();
    final payments = await db.select(db.payments).get();
    final lessons = await db.select(db.lessonRecords).get();
    return {
      'metadata': {
        'version': 1,
        'schemaVersion': 1,
        'createdAt': DateTime.now().toIso8601String(),
        'app': 'Pilates',
        'application': '皮拉提斯課程管理',
      },
      'students': students.map((row) => row.toJson()).toList(),
      'coursePackages': packages.map((row) => row.toJson()).toList(),
      'purchases': purchases.map((row) => row.toJson()).toList(),
      'payments': payments.map((row) => row.toJson()).toList(),
      'lessonRecords': lessons.map((row) => row.toJson()).toList(),
    };
  }

  Future<void> backupAndShare() async {
    final stamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
    final json = const JsonEncoder.withIndent(' ').convert(await buildBackup());
    await saveBackup(
      ExportFileData(
        'pilates_backup_$stamp.json',
        'application/json',
        Uint8List.fromList(utf8.encode(json)),
      ),
    );
  }

  Future<DateTime?> lastBackupTime() => readLastBackupTime();

  Future<BackupSelection?> pickBackup() async {
    final picked = await pickBackupFile();
    if (picked == null) return null;
    final decoded = jsonDecode(utf8.decode(picked.bytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('備份格式不正確');
    }
    _validate(decoded);
    return BackupSelection(picked.name, decoded);
  }

  void _validate(Map<String, dynamic> data) {
    final metadata = data['metadata'];
    if (metadata is! Map ||
        (metadata['version'] != 1 && metadata['schemaVersion'] != 1)) {
      throw const FormatException('不支援的備份版本');
    }
    for (final key in const [
      'students',
      'coursePackages',
      'purchases',
      'payments',
      'lessonRecords',
    ]) {
      if (data[key] is! List) throw FormatException('備份缺少 $key');
    }
  }

  Future<void> restore(Map<String, dynamic> data) async {
    _validate(data);
    List<Map<String, dynamic>> rows(String key) => (data[key] as List)
        .map((value) => Map<String, dynamic>.from(value as Map))
        .toList();

    await db.transaction(() async {
      await db.delete(db.payments).go();
      await db.delete(db.lessonRecords).go();
      await db.delete(db.purchases).go();
      await db.delete(db.students).go();
      await db.delete(db.coursePackages).go();

      for (final value in rows('students')) {
        await db.into(db.students).insert(StudentRow.fromJson(value));
      }
      for (final value in rows('coursePackages')) {
        await db
            .into(db.coursePackages)
            .insert(CoursePackageRow.fromJson(value));
      }
      for (final value in rows('purchases')) {
        await db.into(db.purchases).insert(PurchaseRow.fromJson(value));
      }
      for (final value in rows('payments')) {
        await db.into(db.payments).insert(PaymentRow.fromJson(value));
      }
      for (final value in rows('lessonRecords')) {
        await db.into(db.lessonRecords).insert(LessonRecordRow.fromJson(value));
      }
    });
  }

  Future<void> exportCsvAndShare() async {
    final students = await db.select(db.students).get();
    final purchases = await db.select(db.purchases).get();
    final payments = await db.select(db.payments).get();
    final lessons = await db.select(db.lessonRecords).get();
    await saveCsvFiles([
      _csv('students.csv', [
        ['id', 'name', 'phone', 'joinDate', 'note', 'isActive'],
        ...students.map(
          (x) => [x.id, x.name, x.phone, x.joinDate, x.note, x.isActive],
        ),
      ]),
      _csv('purchases.csv', [
        [
          'id',
          'studentId',
          'coursePackageId',
          'purchaseDate',
          'packageName',
          'purchasedLessons',
          'totalAmount',
          'note',
        ],
        ...purchases.map(
          (x) => [
            x.id,
            x.studentId,
            x.coursePackageId,
            x.purchaseDate,
            x.packageName,
            x.purchasedLessons,
            x.totalAmount,
            x.note,
          ],
        ),
      ]),
      _csv('payments.csv', [
        ['id', 'purchaseId', 'paymentDate', 'amount', 'paymentMethod', 'note'],
        ...payments.map(
          (x) => [
            x.id,
            x.purchaseId,
            x.paymentDate,
            x.amount,
            x.paymentMethod,
            x.note,
          ],
        ),
      ]),
      _csv('lesson_records.csv', [
        [
          'id',
          'studentId',
          'lessonDate',
          'status',
          'content',
          'physicalCondition',
          'note',
        ],
        ...lessons.map(
          (x) => [
            x.id,
            x.studentId,
            x.lessonDate,
            x.status,
            x.content,
            x.physicalCondition,
            x.note,
          ],
        ),
      ]),
    ]);
  }

  ExportFileData _csv(String name, List<List<Object?>> rows) {
    String cell(Object? value) {
      final text = value?.toString() ?? '';
      return '"${text.replaceAll('"', '""')}"';
    }

    final content = rows.map((row) => row.map(cell).join(',')).join('\r\n');
    return ExportFileData(
      name,
      'text/csv;charset=utf-8',
      Uint8List.fromList(utf8.encode('\ufeff$content')),
    );
  }
}
