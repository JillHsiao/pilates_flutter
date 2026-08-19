import 'package:drift/drift.dart';
import 'database_connection.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';
part 'daos/student_dao.dart';
part 'daos/lesson_dao.dart';
part 'daos/purchase_dao.dart';
part 'daos/dashboard_dao.dart';
part 'daos/report_dao.dart';
part 'daos/settings_dao.dart';

@DriftDatabase(
  tables: [Students, CoursePackages, Purchases, Payments, LessonRecords],
  daos: [
    StudentDao,
    LessonDao,
    PurchaseDao,
    DashboardDao,
    ReportDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDatabaseConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch((b) {
        final now = DateTime.now().toIso8601String();
        b.insertAll(coursePackages, [
          CoursePackagesCompanion.insert(
            name: '1堂',
            lessonCount: 1,
            price: 1900,
            sortOrder: const Value(1),
            createdAt: now,
            updatedAt: now,
          ),
          CoursePackagesCompanion.insert(
            name: '10堂',
            lessonCount: 10,
            price: 17000,
            sortOrder: const Value(2),
            createdAt: now,
            updatedAt: now,
          ),
          CoursePackagesCompanion.insert(
            name: '30堂',
            lessonCount: 30,
            price: 48000,
            sortOrder: const Value(3),
            createdAt: now,
            updatedAt: now,
          ),
        ]);
      });
      await _createIndexes();
    },
    onUpgrade: (m, from, to) async {
      // Future schema versions are migrated here without deleting user data.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      if (details.wasCreated == false) await _createIndexes();
    },
  );

  Future<void> _createIndexes() async {
    const statements = [
      'CREATE INDEX IF NOT EXISTS idx_students_name ON students(name)',
      'CREATE INDEX IF NOT EXISTS idx_students_phone ON students(phone)',
      'CREATE INDEX IF NOT EXISTS idx_purchases_student ON purchases(student_id)',
      'CREATE INDEX IF NOT EXISTS idx_purchases_date ON purchases(purchase_date)',
      'CREATE INDEX IF NOT EXISTS idx_payments_purchase ON payments(purchase_id)',
      'CREATE INDEX IF NOT EXISTS idx_payments_date ON payments(payment_date)',
      'CREATE INDEX IF NOT EXISTS idx_lessons_student ON lesson_records(student_id)',
      'CREATE INDEX IF NOT EXISTS idx_lessons_date ON lesson_records(lesson_date)',
    ];
    for (final sql in statements) {
      await customStatement(sql);
    }
  }
}
