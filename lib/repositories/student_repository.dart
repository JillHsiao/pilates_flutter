import 'package:drift/drift.dart';
import '../core/database/app_database.dart';
import '../models/models.dart';

class StudentRepository {
  final AppDatabase db;
  StudentRepository(this.db);
  Future<PagedResult<Student>> list({
    String search = '',
    bool? active,
    int page = 1,
    int pageSize = 20,
  }) async {
    final rows = await db.studentDao.listSummaries(
      search: search,
      active: active,
      limit: pageSize,
      offset: (page - 1) * pageSize,
    );
    final total = await db.studentDao.count(search: search, active: active);
    return PagedResult(
      rows.map(_summary).toList(),
      page,
      pageSize,
      total,
      total == 0 ? 0 : (total / pageSize).ceil(),
    );
  }

  Future<List<Student>> allActive() async =>
      (await db.studentDao.listSummaries(active: true)).map(_summary).toList();
  Future<StudentDetail> get(int id) async {
    final row = await db.studentDao.find(id);
    if (row == null) throw const LocalDataException('找不到學員');
    final summary = await db.studentDao.summaryFor(row);
    final lessons = await db.lessonDao.list(studentId: id);
    final purchases = await db.purchaseDao.list(studentId: id);
    return StudentDetail(
      id: row.id,
      name: row.name,
      phone: row.phone,
      joinDate: row.joinDate,
      note: row.note,
      isActive: row.isActive,
      statistics: StudentStatistics(
        summary.purchased,
        summary.used,
        summary.remaining,
        summary.outstanding,
      ),
      recentLessons: lessons.map(mapLesson).toList(),
      purchases: purchases.map(mapPurchase).toList(),
    );
  }

  Future<int> create(Json data) {
    final now = DateTime.now().toIso8601String();
    return db.studentDao.createStudent(
      StudentsCompanion.insert(
        name: requiredValue(data, 'name'),
        phone: Value(nullableText(data['phone'])),
        joinDate: requiredValue(data, 'joinDate'),
        note: Value(nullableText(data['note'])),
        isActive: Value(data['isActive'] as bool? ?? true),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> update(int id, Json data) async {
    final old = await db.studentDao.find(id);
    if (old == null) throw const LocalDataException('找不到學員');
    await db.studentDao.updateStudent(
      old.copyWith(
        name: requiredValue(data, 'name'),
        phone: Value(nullableText(data['phone'])),
        joinDate: requiredValue(data, 'joinDate'),
        note: Value(nullableText(data['note'])),
        isActive: data['isActive'] as bool? ?? old.isActive,
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> deactivate(int id) => db.studentDao.deactivateStudent(id);
  Student _summary(StudentAggregate x) => Student(
    id: x.student.id,
    name: x.student.name,
    phone: x.student.phone,
    joinDate: x.student.joinDate,
    totalPurchasedLessons: x.purchased,
    usedLessons: x.used,
    remainingLessons: x.remaining,
    outstandingAmount: x.outstanding,
    isActive: x.student.isActive,
  );
}

String requiredValue(Json data, String key) {
  final value = data[key]?.toString().trim() ?? '';
  if (value.isEmpty) throw LocalDataException('$key 為必填');
  return value;
}

String? nullableText(dynamic value) {
  final text = value?.toString().trim();
  return text == null || text.isEmpty ? null : text;
}

Lesson mapLesson(LessonWithStudent x, {String? warning}) => Lesson(
  id: x.lesson.id,
  studentId: x.lesson.studentId,
  studentName: x.studentName,
  lessonDate: x.lesson.lessonDate,
  status: x.lesson.status,
  content: x.lesson.content,
  physicalCondition: x.lesson.physicalCondition,
  note: x.lesson.note,
  warning: warning,
);
Payment mapPayment(PaymentRow x) => Payment(
  id: x.id,
  paymentDate: x.paymentDate,
  amount: x.amount,
  paymentMethod: x.paymentMethod,
  note: x.note,
);
Purchase mapPurchase(PurchaseWithStudent x) {
  final paid = x.paid;
  return Purchase(
    id: x.purchase.id,
    studentId: x.purchase.studentId,
    studentName: x.studentName,
    coursePackageId: x.purchase.coursePackageId,
    purchaseDate: x.purchase.purchaseDate,
    packageName: x.purchase.packageName,
    purchasedLessons: x.purchase.purchasedLessons,
    totalAmount: x.purchase.totalAmount,
    paidAmount: paid,
    outstandingAmount: x.purchase.totalAmount - paid,
    paymentStatus: paid == 0
        ? 'Unpaid'
        : paid >= x.purchase.totalAmount
        ? 'Paid'
        : 'Partial',
    note: x.purchase.note,
    payments: x.payments.map(mapPayment).toList(),
  );
}
