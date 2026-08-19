import 'package:drift/drift.dart';
import '../core/database/app_database.dart';
import '../models/models.dart';
import 'student_repository.dart';

class LessonRepository {
  final AppDatabase db;
  LessonRepository(this.db);
  Future<List<Lesson>> list({
    String? from,
    String? to,
    int? studentId,
    String? status,
  }) async => (await db.lessonDao.list(
    from: from,
    to: to,
    studentId: studentId,
    status: status,
  )).map(mapLesson).toList();
  Future<Lesson> create(Json data) async {
    final studentId = data['studentId'] as int?;
    if (studentId == null || await db.studentDao.find(studentId) == null) {
      throw const LocalDataException('請選擇學員');
    }
    final status = data['status']?.toString() ?? '';
    _validateStatus(status);
    final before = await db.studentDao.summaryFor(
      (await db.studentDao.find(studentId))!,
    );
    final now = DateTime.now().toIso8601String();
    final id = await db.lessonDao.createLesson(
      LessonRecordsCompanion.insert(
        studentId: studentId,
        lessonDate: requiredValue(data, 'lessonDate'),
        status: status,
        content: Value(nullableText(data['content'])),
        physicalCondition: Value(nullableText(data['physicalCondition'])),
        note: Value(nullableText(data['note'])),
        createdAt: now,
        updatedAt: now,
      ),
    );
    final row = (await db.lessonDao.list(
      studentId: studentId,
    )).firstWhere((x) => x.lesson.id == id);
    final warning = status == 'Completed' && before.remaining <= 0
        ? '此學員目前已無剩餘堂數，請確認是否需要續課。'
        : null;
    return mapLesson(row, warning: warning);
  }

  Future<Lesson> update(int id, Json data) async {
    final existing = (await db.lessonDao.list())
        .where((x) => x.lesson.id == id)
        .firstOrNull;
    if (existing == null) throw const LocalDataException('找不到上課紀錄');
    final studentId = data['studentId'] as int?;
    if (studentId == null || await db.studentDao.find(studentId) == null) {
      throw const LocalDataException('請選擇學員');
    }
    final status = data['status']?.toString() ?? '';
    _validateStatus(status);
    final old = existing.lesson;
    final changed = old.copyWith(
      studentId: studentId,
      lessonDate: requiredValue(data, 'lessonDate'),
      status: status,
      content: Value(nullableText(data['content'])),
      physicalCondition: Value(nullableText(data['physicalCondition'])),
      note: Value(nullableText(data['note'])),
      updatedAt: DateTime.now().toIso8601String(),
    );
    await db.lessonDao.updateLesson(changed);
    return mapLesson(
      (await db.lessonDao.list()).firstWhere((x) => x.lesson.id == id),
    );
  }

  Future<void> delete(int id) async {
    if (await db.lessonDao.deleteLesson(id) == 0) {
      throw const LocalDataException('找不到上課紀錄');
    }
  }

  void _validateStatus(String value) {
    if (!const {'Completed', 'Leave', 'Cancelled', 'Makeup'}.contains(value)) {
      throw const LocalDataException('上課狀態無效');
    }
  }
}
