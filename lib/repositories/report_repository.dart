import '../core/database/app_database.dart';
import '../models/models.dart';

class ReportRepository {
  final AppDatabase db;
  ReportRepository(this.db);
  Future<ReportData> get(String from, String to) async {
    final r = await db.reportDao.report(from, to);
    return ReportData(
      r.revenue,
      r.completedLessons,
      r.purchasedLessons,
      r.newStudents,
      r.months
          .map(
            (x) => MonthlyReportRow(
              x.month,
              x.revenue,
              x.completedLessons,
              x.purchasedLessons,
              x.newStudents,
            ),
          )
          .toList(),
    );
  }
}
