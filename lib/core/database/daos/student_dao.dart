part of '../app_database.dart';

class StudentAggregate {
  final StudentRow student;
  final int purchased, used, outstanding;
  const StudentAggregate(
    this.student,
    this.purchased,
    this.used,
    this.outstanding,
  );
  int get remaining => purchased - used;
}

@DriftAccessor(tables: [Students, Purchases, Payments, LessonRecords])
class StudentDao extends DatabaseAccessor<AppDatabase> with _$StudentDaoMixin {
  StudentDao(super.db);

  Future<List<StudentAggregate>> listSummaries({
    String search = '',
    bool? active,
    int? limit,
    int offset = 0,
  }) async {
    final q = select(students);
    if (search.trim().isNotEmpty) {
      final pattern = '%${search.trim()}%';
      q.where((s) => s.name.like(pattern) | s.phone.like(pattern));
    }
    if (active != null) q.where((s) => s.isActive.equals(active));
    q.orderBy([
      (s) => OrderingTerm.desc(s.isActive),
      (s) => OrderingTerm.asc(s.name),
    ]);
    if (limit != null) q.limit(limit, offset: offset);
    final rows = await q.get();
    return Future.wait(rows.map(summaryFor));
  }

  Future<int> count({String search = '', bool? active}) async {
    final countExpr = students.id.count();
    final q = selectOnly(students)..addColumns([countExpr]);
    if (search.trim().isNotEmpty) {
      final pattern = '%${search.trim()}%';
      q.where(students.name.like(pattern) | students.phone.like(pattern));
    }
    if (active != null) q.where(students.isActive.equals(active));
    return (await q.map((r) => r.read(countExpr) ?? 0).getSingle());
  }

  Future<StudentAggregate> summaryFor(StudentRow student) async {
    final purchasedExpr = purchases.purchasedLessons.sum();
    final purchased =
        await (selectOnly(purchases)
              ..addColumns([purchasedExpr])
              ..where(purchases.studentId.equals(student.id)))
            .map((r) => r.read(purchasedExpr) ?? 0)
            .getSingle();
    final usedExpr = lessonRecords.id.count();
    final used =
        await (selectOnly(lessonRecords)
              ..addColumns([usedExpr])
              ..where(
                lessonRecords.studentId.equals(student.id) &
                    lessonRecords.status.equals('Completed'),
              ))
            .map((r) => r.read(usedExpr) ?? 0)
            .getSingle();
    final totalExpr = purchases.totalAmount.sum();
    final total =
        await (selectOnly(purchases)
              ..addColumns([totalExpr])
              ..where(purchases.studentId.equals(student.id)))
            .map((r) => r.read(totalExpr) ?? 0)
            .getSingle();
    final paidExpr = payments.amount.sum();
    final paidQuery =
        selectOnly(payments).join([
            innerJoin(purchases, purchases.id.equalsExp(payments.purchaseId)),
          ])
          ..addColumns([paidExpr])
          ..where(purchases.studentId.equals(student.id));
    final paid = await paidQuery.map((r) => r.read(paidExpr) ?? 0).getSingle();
    return StudentAggregate(student, purchased, used, total - paid);
  }

  Future<StudentRow?> find(int id) =>
      (select(students)..where((s) => s.id.equals(id))).getSingleOrNull();
  Future<List<StudentRow>> allActive() =>
      (select(students)
            ..where((s) => s.isActive.equals(true))
            ..orderBy([(s) => OrderingTerm.asc(s.name)]))
          .get();
  Future<int> createStudent(StudentsCompanion value) =>
      into(students).insert(value);
  Future<bool> updateStudent(StudentRow value) =>
      update(students).replace(value);
  Future<void> deactivateStudent(int id) =>
      (update(students)..where((s) => s.id.equals(id))).write(
        StudentsCompanion(
          isActive: const Value(false),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
}
