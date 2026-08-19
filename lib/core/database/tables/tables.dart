import 'package:drift/drift.dart';

@DataClassName('StudentRow')
class Students extends Table {
  @override
  String get tableName => 'students';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get joinDate => text().named('join_date')();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
}

@DataClassName('CoursePackageRow')
class CoursePackages extends Table {
  @override
  String get tableName => 'course_packages';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get lessonCount => integer()
      .named('lesson_count')
      .check(const CustomExpression<bool>('lesson_count > 0'))();
  IntColumn get price =>
      integer().check(const CustomExpression<bool>('price >= 0'))();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  IntColumn get sortOrder =>
      integer().named('sort_order').withDefault(const Constant(0))();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
}

@DataClassName('PurchaseRow')
class Purchases extends Table {
  @override
  String get tableName => 'purchases';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer()
      .named('student_id')
      .references(Students, #id, onDelete: KeyAction.restrict)();
  IntColumn get coursePackageId => integer()
      .named('course_package_id')
      .nullable()
      .references(CoursePackages, #id, onDelete: KeyAction.setNull)();
  TextColumn get purchaseDate => text().named('purchase_date')();
  TextColumn get packageName => text().named('package_name')();
  IntColumn get purchasedLessons => integer()
      .named('purchased_lessons')
      .check(const CustomExpression<bool>('purchased_lessons > 0'))();
  IntColumn get totalAmount => integer()
      .named('total_amount')
      .check(const CustomExpression<bool>('total_amount >= 0'))();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
}

@DataClassName('PaymentRow')
class Payments extends Table {
  @override
  String get tableName => 'payments';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get purchaseId => integer()
      .named('purchase_id')
      .references(Purchases, #id, onDelete: KeyAction.cascade)();
  TextColumn get paymentDate => text().named('payment_date')();
  IntColumn get amount =>
      integer().check(const CustomExpression<bool>('amount > 0'))();
  TextColumn get paymentMethod => text().named('payment_method')();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
}

@DataClassName('LessonRecordRow')
class LessonRecords extends Table {
  @override
  String get tableName => 'lesson_records';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer()
      .named('student_id')
      .references(Students, #id, onDelete: KeyAction.restrict)();
  TextColumn get lessonDate => text().named('lesson_date')();
  TextColumn get status => text()();
  TextColumn get content => text().nullable()();
  TextColumn get physicalCondition =>
      text().named('physical_condition').nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
}
