part of '../app_database.dart';

class MonthlySnapshot {
  final String month;
  final int revenue, completedLessons, purchasedLessons, newStudents;
  const MonthlySnapshot(
    this.month,
    this.revenue,
    this.completedLessons,
    this.purchasedLessons,
    this.newStudents,
  );
}

class ReportSnapshot {
  final List<MonthlySnapshot> months;
  const ReportSnapshot(this.months);
  int get revenue => months.fold(0, (s, x) => s + x.revenue);
  int get completedLessons => months.fold(0, (s, x) => s + x.completedLessons);
  int get purchasedLessons => months.fold(0, (s, x) => s + x.purchasedLessons);
  int get newStudents => months.fold(0, (s, x) => s + x.newStudents);
}

@DriftAccessor(tables: [Students, Purchases, Payments, LessonRecords])
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(super.db);
  Future<ReportSnapshot> report(String from, String to) async {
    if (to.compareTo(from) < 0) throw const LocalDataException('結束日期不可早於開始日期');
    final paymentRows =
        await (select(payments)..where(
              (x) =>
                  x.paymentDate.isBiggerOrEqualValue(from) &
                  x.paymentDate.isSmallerOrEqualValue(to),
            ))
            .get();
    final lessonRows =
        await (select(lessonRecords)..where(
              (x) =>
                  x.lessonDate.isBiggerOrEqualValue(from) &
                  x.lessonDate.isSmallerOrEqualValue(to) &
                  x.status.equals('Completed'),
            ))
            .get();
    final purchaseRows =
        await (select(purchases)..where(
              (x) =>
                  x.purchaseDate.isBiggerOrEqualValue(from) &
                  x.purchaseDate.isSmallerOrEqualValue(to),
            ))
            .get();
    final studentRows =
        await (select(students)..where(
              (x) =>
                  x.joinDate.isBiggerOrEqualValue(from) &
                  x.joinDate.isSmallerOrEqualValue(to),
            ))
            .get();
    final first = DateTime.parse('${from.substring(0, 7)}-01');
    final last = DateTime.parse('${to.substring(0, 7)}-01');
    final result = <MonthlySnapshot>[];
    for (
      var cursor = first;
      !cursor.isAfter(last);
      cursor = DateTime(cursor.year, cursor.month + 1, 1)
    ) {
      final month =
          '${cursor.year.toString().padLeft(4, '0')}-${cursor.month.toString().padLeft(2, '0')}';
      result.add(
        MonthlySnapshot(
          month,
          paymentRows
              .where((x) => x.paymentDate.startsWith(month))
              .fold(0, (s, x) => s + x.amount),
          lessonRows.where((x) => x.lessonDate.startsWith(month)).length,
          purchaseRows
              .where((x) => x.purchaseDate.startsWith(month))
              .fold(0, (s, x) => s + x.purchasedLessons),
          studentRows.where((x) => x.joinDate.startsWith(month)).length,
        ),
      );
    }
    return ReportSnapshot(result);
  }
}
