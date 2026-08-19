import '../core/database/app_database.dart';
import '../models/models.dart';
import 'student_repository.dart';

class DashboardRepository {
  final AppDatabase db;
  DashboardRepository(this.db);
  Future<DashboardData> get() async {
    final d = await db.dashboardDao.snapshot();
    return DashboardData(
      monthlyRevenue: d.monthlyRevenue,
      monthlyCompletedLessons: d.monthlyCompletedLessons,
      activeStudents: d.activeStudents,
      outstandingAmount: d.outstanding,
      lowLessonStudents: d.lowStudents
          .map(
            (x) => LowLessonStudent(
              x.summary.student.id,
              x.summary.student.name,
              x.summary.remaining,
              x.lastLessonDate,
            ),
          )
          .toList(),
      recentLessons: d.recentLessons.map(mapLesson).toList(),
      revenueTrend: d.revenueTrend
          .map((x) => TrendPoint(x.month, x.value))
          .toList(),
      lessonTrend: d.lessonTrend
          .map((x) => TrendPoint(x.month, x.value))
          .toList(),
    );
  }
}
