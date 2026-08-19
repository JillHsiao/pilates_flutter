import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/app_database.dart';
import '../models/models.dart';
import '../repositories/course_package_repository.dart';
import '../repositories/dashboard_repository.dart';
import '../repositories/lesson_repository.dart';
import '../repositories/purchase_repository.dart';
import '../repositories/report_repository.dart';
import '../repositories/student_repository.dart';
import '../services/backup/backup_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
final studentRepositoryProvider = Provider(
  (ref) => StudentRepository(ref.watch(databaseProvider)),
);
final lessonRepositoryProvider = Provider(
  (ref) => LessonRepository(ref.watch(databaseProvider)),
);
final purchaseRepositoryProvider = Provider(
  (ref) => PurchaseRepository(ref.watch(databaseProvider)),
);
final dashboardRepositoryProvider = Provider(
  (ref) => DashboardRepository(ref.watch(databaseProvider)),
);
final reportRepositoryProvider = Provider(
  (ref) => ReportRepository(ref.watch(databaseProvider)),
);
final packageRepositoryProvider = Provider(
  (ref) => CoursePackageRepository(ref.watch(databaseProvider)),
);
final backupServiceProvider = Provider(
  (ref) => BackupService(ref.watch(databaseProvider)),
);
final lastBackupProvider = FutureProvider(
  (ref) => ref.watch(backupServiceProvider).lastBackupTime(),
);

typedef StudentQuery = ({String search, bool? active, int page});
typedef LessonQuery = ({
  String? from,
  String? to,
  int? studentId,
  String? status,
});
typedef ReportQuery = ({String from, String to});
final dashboardProvider = FutureProvider(
  (ref) => ref.watch(dashboardRepositoryProvider).get(),
);
final studentsProvider =
    FutureProvider.family<PagedResult<Student>, StudentQuery>(
      (ref, q) => ref
          .watch(studentRepositoryProvider)
          .list(search: q.search, active: q.active, page: q.page),
    );
final allStudentsProvider = FutureProvider(
  (ref) => ref.watch(studentRepositoryProvider).allActive(),
);
final studentDetailProvider = FutureProvider.family<StudentDetail, int>(
  (ref, id) => ref.watch(studentRepositoryProvider).get(id),
);
final lessonsProvider = FutureProvider.family<List<Lesson>, LessonQuery>(
  (ref, q) => ref
      .watch(lessonRepositoryProvider)
      .list(from: q.from, to: q.to, studentId: q.studentId, status: q.status),
);
final purchasesProvider = FutureProvider(
  (ref) => ref.watch(purchaseRepositoryProvider).list(),
);
final packagesProvider = FutureProvider(
  (ref) => ref.watch(packageRepositoryProvider).list(),
);
final reportProvider = FutureProvider.family<ReportData, ReportQuery>(
  (ref, q) => ref.watch(reportRepositoryProvider).get(q.from, q.to),
);

void refreshBusinessData(WidgetRef ref) {
  ref.invalidate(dashboardProvider);
  ref.invalidate(studentsProvider);
  ref.invalidate(allStudentsProvider);
  ref.invalidate(studentDetailProvider);
  ref.invalidate(lessonsProvider);
  ref.invalidate(purchasesProvider);
  ref.invalidate(reportProvider);
}
