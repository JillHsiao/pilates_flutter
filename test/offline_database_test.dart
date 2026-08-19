import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_flutter/core/database/app_database.dart';
import 'package:pilates_flutter/repositories/lesson_repository.dart';
import 'package:pilates_flutter/repositories/purchase_repository.dart';
import 'package:pilates_flutter/repositories/student_repository.dart';
import 'package:pilates_flutter/services/backup/backup_service.dart';

void main() {
  late AppDatabase db;
  late StudentRepository students;
  late PurchaseRepository purchases;
  late LessonRepository lessons;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    students = StudentRepository(db);
    purchases = PurchaseRepository(db);
    lessons = LessonRepository(db);
  });

  tearDown(() => db.close());

  test('新資料庫只建立預設方案，不建立示範學員', () async {
    expect(await db.select(db.students).get(), isEmpty);
    final packages = await db.select(db.coursePackages).get();
    expect(packages.map((x) => x.name), ['1堂', '10堂', '30堂']);
    expect(packages.map((x) => x.price), [1900, 17000, 48000]);
  });

  test('完整離線流程、摘要計算與串聯刪除', () async {
    final studentId = await students.create({
      'name': '蕭宇筑',
      'joinDate': '2026-08-18',
      'isActive': true,
    });
    final purchaseId = await purchases.create({
      'studentId': studentId,
      'coursePackageId': 1,
      'purchaseDate': '2026-08-18',
      'packageName': '1堂',
      'purchasedLessons': 1,
      'totalAmount': 1900,
      'initialPayment': {
        'amount': 1900,
        'paymentDate': '2026-08-18',
        'paymentMethod': 'Cash',
      },
    });
    await lessons.create({
      'studentId': studentId,
      'lessonDate': '2026-08-18',
      'status': 'Leave',
    });
    await lessons.create({
      'studentId': studentId,
      'lessonDate': '2026-08-19',
      'status': 'Completed',
    });

    final detail = await students.get(studentId);
    expect(detail.statistics.totalPurchasedLessons, 1);
    expect(detail.statistics.usedLessons, 1);
    expect(detail.statistics.remainingLessons, 0);
    expect(detail.statistics.outstandingAmount, 0);
    expect(detail.recentLessons, hasLength(2));

    await purchases.delete(purchaseId);
    expect(await db.select(db.payments).get(), isEmpty);
    expect((await students.get(studentId)).statistics.totalPurchasedLessons, 0);
  });

  test('禁止付款超過課程總額', () async {
    final studentId = await students.create({
      'name': '付款測試',
      'joinDate': '2026-08-18',
    });
    final purchaseId = await purchases.create({
      'studentId': studentId,
      'purchaseDate': '2026-08-18',
      'packageName': '自訂',
      'purchasedLessons': 2,
      'totalAmount': 1000,
    });
    await purchases.addPayment(purchaseId, {
      'paymentDate': '2026-08-18',
      'amount': 600,
      'paymentMethod': 'Transfer',
    });
    expect(
      () => purchases.addPayment(purchaseId, {
        'paymentDate': '2026-08-18',
        'amount': 401,
        'paymentMethod': 'Transfer',
      }),
      throwsA(isA<LocalDataException>()),
    );
  });

  test('JSON 備份可在交易中還原並保留主鍵', () async {
    final studentId = await students.create({
      'name': '備份學員',
      'joinDate': '2026-08-18',
    });
    final service = BackupService(db);
    final purchaseId = await purchases.create({
      'studentId': studentId,
      'purchaseDate': '2026-08-18',
      'packageName': '10堂',
      'purchasedLessons': 10,
      'totalAmount': 17000,
      'initialPayment': {
        'amount': 1000,
        'paymentDate': '2026-08-18',
        'paymentMethod': 'Transfer',
      },
    });
    await lessons.create({
      'studentId': studentId,
      'lessonDate': '2026-08-18',
      'status': 'Completed',
    });
    final backup = await service.buildBackup();
    await db.delete(db.payments).go();
    await db.delete(db.lessonRecords).go();
    await db.delete(db.purchases).go();
    await db.delete(db.students).go();
    await db.delete(db.coursePackages).go();
    expect(await db.select(db.students).get(), isEmpty);

    await service.restore(backup);
    final restored = await db.select(db.students).get();
    expect(restored.single.id, studentId);
    expect(restored.single.name, '備份學員');
    expect(await db.select(db.coursePackages).get(), hasLength(3));
    expect((await db.select(db.purchases).get()).single.id, purchaseId);
    expect((await db.select(db.payments).get()).single.purchaseId, purchaseId);
    expect(
      (await db.select(db.lessonRecords).get()).single.studentId,
      studentId,
    );
  });

  test('30堂三次收款正確切換 Partial 與 Paid', () async {
    final studentId = await students.create({
      'name': '分期學員',
      'joinDate': '2026-08-18',
    });
    final purchaseId = await purchases.create({
      'studentId': studentId,
      'purchaseDate': '2026-08-18',
      'packageName': '30堂',
      'purchasedLessons': 30,
      'totalAmount': 48000,
    });
    for (var index = 0; index < 3; index++) {
      await purchases.addPayment(purchaseId, {
        'paymentDate': '2026-08-${18 + index}',
        'amount': 16000,
        'paymentMethod': 'Transfer',
      });
      final purchase = (await purchases.list()).single;
      expect(purchase.outstandingAmount, 48000 - 16000 * (index + 1));
      expect(purchase.paymentStatus, index == 2 ? 'Paid' : 'Partial');
    }
  });

  test('實體 SQLite 檔關閉重開後學員、購課與付款仍存在', () async {
    await db.close();
    final directory = await Directory.systemTemp.createTemp('pilates_test_');
    final file = File('${directory.path}${Platform.pathSeparator}pilates.db');
    db = AppDatabase.forTesting(NativeDatabase(file));
    students = StudentRepository(db);
    purchases = PurchaseRepository(db);
    final studentId = await students.create({
      'name': '持久化學員',
      'joinDate': '2026-08-18',
    });
    await purchases.create({
      'studentId': studentId,
      'purchaseDate': '2026-08-18',
      'packageName': '1堂',
      'purchasedLessons': 1,
      'totalAmount': 1900,
      'initialPayment': {
        'amount': 1900,
        'paymentDate': '2026-08-18',
        'paymentMethod': 'Cash',
      },
    });
    await db.close();

    db = AppDatabase.forTesting(NativeDatabase(file));
    students = StudentRepository(db);
    purchases = PurchaseRepository(db);
    expect((await students.get(studentId)).name, '持久化學員');
    expect((await purchases.list()).single.payments.single.amount, 1900);
    await db.close();
    await directory.delete(recursive: true);
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });
}
