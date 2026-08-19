part of '../app_database.dart';

class LessonWithStudent {
  final LessonRecordRow lesson;
  final String studentName;
  const LessonWithStudent(this.lesson, this.studentName);
}

@DriftAccessor(tables: [LessonRecords, Students])
class LessonDao extends DatabaseAccessor<AppDatabase> with _$LessonDaoMixin {
  LessonDao(super.db);
  Future<List<LessonWithStudent>> list({
    String? from,
    String? to,
    int? studentId,
    String? status,
    int? limit,
  }) async {
    final q = select(lessonRecords).join([
      innerJoin(students, students.id.equalsExp(lessonRecords.studentId)),
    ]);
    if (from != null) {
      q.where(lessonRecords.lessonDate.isBiggerOrEqualValue(from));
    }
    if (to != null) q.where(lessonRecords.lessonDate.isSmallerOrEqualValue(to));
    if (studentId != null) q.where(lessonRecords.studentId.equals(studentId));
    if (status != null) q.where(lessonRecords.status.equals(status));
    q.orderBy([
      OrderingTerm.desc(lessonRecords.lessonDate),
      OrderingTerm.desc(lessonRecords.createdAt),
    ]);
    if (limit != null) q.limit(limit);
    return (await q.get())
        .map(
          (r) => LessonWithStudent(
            r.readTable(lessonRecords),
            r.readTable(students).name,
          ),
        )
        .toList();
  }

  Future<int> createLesson(LessonRecordsCompanion value) =>
      into(lessonRecords).insert(value);
  Future<bool> updateLesson(LessonRecordRow value) =>
      update(lessonRecords).replace(value);
  Future<int> deleteLesson(int id) =>
      (delete(lessonRecords)..where((x) => x.id.equals(id))).go();
}
