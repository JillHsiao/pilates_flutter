part of '../app_database.dart';

class TrendSnapshot {
  final String month;
  final int value;
  const TrendSnapshot(this.month, this.value);
}

class LowStudentSnapshot {
  final StudentAggregate summary;
  final String? lastLessonDate;
  const LowStudentSnapshot(this.summary, this.lastLessonDate);
}

class DashboardSnapshot {
  final int monthlyRevenue,
      monthlyCompletedLessons,
      activeStudents,
      outstanding;
  final List<LowStudentSnapshot> lowStudents;
  final List<LessonWithStudent> recentLessons;
  final List<TrendSnapshot> revenueTrend, lessonTrend;
  const DashboardSnapshot(
    this.monthlyRevenue,
    this.monthlyCompletedLessons,
    this.activeStudents,
    this.outstanding,
    this.lowStudents,
    this.recentLessons,
    this.revenueTrend,
    this.lessonTrend,
  );
}

@DriftAccessor(tables: [Students, Purchases, Payments, LessonRecords])
class DashboardDao extends DatabaseAccessor<AppDatabase>
    with _$DashboardDaoMixin {
  DashboardDao(super.db);
  Future<DashboardSnapshot> snapshot() async {
    final now = DateTime.now();
    final start =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-01';
    final next = DateTime(now.year, now.month + 1, 1);
    final end =
        '${next.year.toString().padLeft(4, '0')}-${next.month.toString().padLeft(2, '0')}-01';
    final revenueExpr = payments.amount.sum();
    final monthlyRevenue =
        await (selectOnly(payments)
              ..addColumns([revenueExpr])
              ..where(
                payments.paymentDate.isBiggerOrEqualValue(start) &
                    payments.paymentDate.isSmallerThanValue(end),
              ))
            .map((r) => r.read(revenueExpr) ?? 0)
            .getSingle();
    final lessonsExpr = lessonRecords.id.count();
    final monthlyLessons =
        await (selectOnly(lessonRecords)
              ..addColumns([lessonsExpr])
              ..where(
                lessonRecords.lessonDate.isBiggerOrEqualValue(start) &
                    lessonRecords.lessonDate.isSmallerThanValue(end) &
                    lessonRecords.status.equals('Completed'),
              ))
            .map((r) => r.read(lessonsExpr) ?? 0)
            .getSingle();
    final activeExpr = students.id.count();
    final active =
        await (selectOnly(students)
              ..addColumns([activeExpr])
              ..where(students.isActive.equals(true)))
            .map((r) => r.read(activeExpr) ?? 0)
            .getSingle();
    final totalExpr = purchases.totalAmount.sum();
    final total = await (selectOnly(
      purchases,
    )..addColumns([totalExpr])).map((r) => r.read(totalExpr) ?? 0).getSingle();
    final paidExpr = payments.amount.sum();
    final paid = await (selectOnly(
      payments,
    )..addColumns([paidExpr])).map((r) => r.read(paidExpr) ?? 0).getSingle();
    final activeSummaries = await attachedDatabase.studentDao.listSummaries(
      active: true,
    );
    final low = <LowStudentSnapshot>[];
    for (final summary in activeSummaries.where((x) => x.remaining <= 2)) {
      final dateExpr = lessonRecords.lessonDate.max();
      final last =
          await (selectOnly(lessonRecords)
                ..addColumns([dateExpr])
                ..where(lessonRecords.studentId.equals(summary.student.id)))
              .map((r) => r.read(dateExpr))
              .getSingle();
      low.add(LowStudentSnapshot(summary, last));
    }
    return DashboardSnapshot(
      monthlyRevenue,
      monthlyLessons,
      active,
      total - paid,
      low,
      await attachedDatabase.lessonDao.list(limit: 8),
      await _paymentTrend(now),
      await _lessonTrend(now),
    );
  }

  Future<List<TrendSnapshot>> _paymentTrend(DateTime now) async {
    final rows = await select(payments).get();
    return _months(
      now,
      (month) => rows
          .where((x) => x.paymentDate.startsWith(month))
          .fold(0, (sum, x) => sum + x.amount),
    );
  }

  Future<List<TrendSnapshot>> _lessonTrend(DateTime now) async {
    final rows = await (select(
      lessonRecords,
    )..where((x) => x.status.equals('Completed'))).get();
    return _months(
      now,
      (month) => rows.where((x) => x.lessonDate.startsWith(month)).length,
    );
  }

  List<TrendSnapshot> _months(DateTime now, int Function(String) value) => [
    for (var i = 11; i >= 0; i--) _month(now, i, value),
  ];
  TrendSnapshot _month(DateTime now, int back, int Function(String) value) {
    final d = DateTime(now.year, now.month - back, 1);
    final month =
        '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}';
    return TrendSnapshot(month, value(month));
  }
}
