import 'package:drift/drift.dart';
import '../core/database/app_database.dart';
import '../models/models.dart';
import 'student_repository.dart';

class CoursePackageRepository {
  final AppDatabase db;
  CoursePackageRepository(this.db);
  Future<List<CoursePackage>> list() async =>
      (await db.settingsDao.packagesList())
          .map(
            (x) => CoursePackage(
              id: x.id,
              name: x.name,
              lessons: x.lessonCount,
              price: x.price,
              isActive: x.isActive,
              sortOrder: x.sortOrder,
            ),
          )
          .toList();
  Future<int> create(Json data) {
    final lessons = data['lessons'] as int? ?? 0;
    final price = data['price'] as int? ?? -1;
    if (lessons <= 0) throw const LocalDataException('堂數需大於 0');
    if (price < 0) throw const LocalDataException('價格不可小於 0');
    final now = DateTime.now().toIso8601String();
    return db.settingsDao.createPackage(
      CoursePackagesCompanion.insert(
        name: requiredValue(data, 'name'),
        lessonCount: lessons,
        price: price,
        isActive: Value(data['isActive'] as bool? ?? true),
        sortOrder: Value(data['sortOrder'] as int? ?? 0),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> update(int id, Json data) async {
    final old = (await db.settingsDao.packagesList())
        .where((x) => x.id == id)
        .firstOrNull;
    if (old == null) throw const LocalDataException('找不到課程方案');
    final lessons = data['lessons'] as int? ?? 0;
    final price = data['price'] as int? ?? -1;
    if (lessons <= 0) throw const LocalDataException('堂數需大於 0');
    if (price < 0) throw const LocalDataException('價格不可小於 0');
    await db.settingsDao.updatePackage(
      old.copyWith(
        name: requiredValue(data, 'name'),
        lessonCount: lessons,
        price: price,
        isActive: data['isActive'] as bool? ?? old.isActive,
        sortOrder: data['sortOrder'] as int? ?? old.sortOrder,
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> deactivate(int id) => db.settingsDao.deactivatePackage(id);
}
