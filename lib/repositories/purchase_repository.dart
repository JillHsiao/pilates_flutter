import 'package:drift/drift.dart';
import '../core/database/app_database.dart';
import '../models/models.dart';
import 'student_repository.dart';

class PurchaseRepository {
  final AppDatabase db;
  PurchaseRepository(this.db);
  Future<List<Purchase>> list({int? studentId}) async =>
      (await db.purchaseDao.list(
        studentId: studentId,
      )).map(mapPurchase).toList();
  Future<int> create(Json data) async {
    final studentId = data['studentId'] as int?;
    if (studentId == null || await db.studentDao.find(studentId) == null) {
      throw const LocalDataException('請選擇學員');
    }
    final lessons = data['purchasedLessons'] as int? ?? 0;
    final total = data['totalAmount'] as int? ?? -1;
    if (lessons <= 0) throw const LocalDataException('堂數需大於 0');
    if (total < 0) throw const LocalDataException('金額不可小於 0');
    final initial = data['initialPayment'] as Json?;
    final initialAmount = initial?['amount'] as int? ?? 0;
    if (initialAmount < 0 || initialAmount > total) {
      throw const LocalDataException('付款金額不可超過尚欠金額');
    }
    _validateMethod(initial?['paymentMethod']?.toString() ?? 'Transfer');
    final now = DateTime.now().toIso8601String();
    return db.purchaseDao.createPurchase(
      PurchasesCompanion.insert(
        studentId: studentId,
        coursePackageId: Value(data['coursePackageId'] as int?),
        purchaseDate: requiredValue(data, 'purchaseDate'),
        packageName: requiredValue(data, 'packageName'),
        purchasedLessons: lessons,
        totalAmount: total,
        note: Value(nullableText(data['note'])),
        createdAt: now,
        updatedAt: now,
      ),
      initialAmount: initialAmount,
      paymentDate: initial?['paymentDate']?.toString() ?? now.substring(0, 10),
      paymentMethod: initial?['paymentMethod']?.toString() ?? 'Transfer',
    );
  }

  Future<void> update(int id, Json data) async {
    final old = await db.purchaseDao.find(id);
    if (old == null) throw const LocalDataException('找不到購課紀錄');
    final lessons = data['purchasedLessons'] as int? ?? 0;
    final total = data['totalAmount'] as int? ?? -1;
    if (lessons <= 0) throw const LocalDataException('堂數需大於 0');
    if (total < 0) throw const LocalDataException('金額不可小於 0');
    final studentId = data['studentId'] as int?;
    if (studentId == null || await db.studentDao.find(studentId) == null) {
      throw const LocalDataException('請選擇學員');
    }
    await db.purchaseDao.updatePurchase(
      old.copyWith(
        studentId: studentId,
        coursePackageId: Value(data['coursePackageId'] as int?),
        purchaseDate: requiredValue(data, 'purchaseDate'),
        packageName: requiredValue(data, 'packageName'),
        purchasedLessons: lessons,
        totalAmount: total,
        note: Value(nullableText(data['note'])),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> delete(int id) => db.purchaseDao.deletePurchase(id);
  Future<int> addPayment(int purchaseId, Json data) {
    final amount = data['amount'] as int? ?? 0;
    if (amount <= 0) throw const LocalDataException('付款金額需大於 0');
    final method = data['paymentMethod']?.toString() ?? '';
    _validateMethod(method);
    return db.purchaseDao.addPayment(
      PaymentsCompanion.insert(
        purchaseId: purchaseId,
        paymentDate: requiredValue(data, 'paymentDate'),
        amount: amount,
        paymentMethod: method,
        note: Value(nullableText(data['note'])),
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> updatePayment(int id, Json data) async {
    final matches = (await db.select(db.payments).get()).where(
      (x) => x.id == id,
    );
    if (matches.isEmpty) throw const LocalDataException('找不到付款紀錄');
    final amount = data['amount'] as int? ?? 0;
    if (amount <= 0) throw const LocalDataException('付款金額需大於 0');
    final method = data['paymentMethod']?.toString() ?? '';
    _validateMethod(method);
    final old = matches.first;
    await db.purchaseDao.updatePayment(
      old.copyWith(
        paymentDate: requiredValue(data, 'paymentDate'),
        amount: amount,
        paymentMethod: method,
        note: Value(nullableText(data['note'])),
      ),
    );
  }

  Future<void> deletePayment(int id) async {
    if (await db.purchaseDao.deletePayment(id) == 0) {
      throw const LocalDataException('找不到付款紀錄');
    }
  }

  void _validateMethod(String value) {
    if (!const {
      'Cash',
      'Transfer',
      'LinePay',
      'CreditCard',
      'Other',
    }.contains(value)) {
      throw const LocalDataException('付款方式無效');
    }
  }
}
