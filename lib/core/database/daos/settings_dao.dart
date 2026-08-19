part of '../app_database.dart';

@DriftAccessor(tables: [CoursePackages, Purchases])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);
  Future<List<CoursePackageRow>> packagesList() => (select(
    coursePackages,
  )..orderBy([(x) => OrderingTerm.asc(x.sortOrder)])).get();
  Future<int> createPackage(CoursePackagesCompanion value) =>
      into(coursePackages).insert(value);
  Future<bool> updatePackage(CoursePackageRow value) =>
      update(coursePackages).replace(value);
  Future<void> deactivatePackage(int id) =>
      (update(coursePackages)..where((x) => x.id.equals(id))).write(
        CoursePackagesCompanion(
          isActive: const Value(false),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
}
