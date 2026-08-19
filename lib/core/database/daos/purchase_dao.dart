part of '../app_database.dart';

class PurchaseWithStudent {
  final PurchaseRow purchase;
  final String studentName;
  final List<PaymentRow> payments;
  const PurchaseWithStudent(this.purchase, this.studentName, this.payments);
  int get paid => payments.fold(0, (sum, x) => sum + x.amount);
  int get outstanding => purchase.totalAmount - paid;
}

@DriftAccessor(tables: [Purchases, Payments, Students])
class PurchaseDao extends DatabaseAccessor<AppDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(super.db);
  Future<List<PurchaseWithStudent>> list({int? studentId}) async {
    final q = select(
      purchases,
    ).join([innerJoin(students, students.id.equalsExp(purchases.studentId))]);
    if (studentId != null) q.where(purchases.studentId.equals(studentId));
    q.orderBy([
      OrderingTerm.desc(purchases.purchaseDate),
      OrderingTerm.desc(purchases.createdAt),
    ]);
    final rows = await q.get();
    return Future.wait(
      rows.map((r) async {
        final p = r.readTable(purchases);
        return PurchaseWithStudent(
          p,
          r.readTable(students).name,
          await paymentsFor(p.id),
        );
      }),
    );
  }

  Future<List<PaymentRow>> paymentsFor(int purchaseId) =>
      (select(payments)
            ..where((x) => x.purchaseId.equals(purchaseId))
            ..orderBy([
              (x) => OrderingTerm.desc(x.paymentDate),
              (x) => OrderingTerm.desc(x.createdAt),
            ]))
          .get();
  Future<int> paidFor(int purchaseId, {int? excludingPaymentId}) async {
    final expr = payments.amount.sum();
    final q = selectOnly(payments)
      ..addColumns([expr])
      ..where(payments.purchaseId.equals(purchaseId));
    if (excludingPaymentId != null) {
      q.where(payments.id.equals(excludingPaymentId).not());
    }
    return q.map((r) => r.read(expr) ?? 0).getSingle();
  }

  Future<PurchaseRow?> find(int id) =>
      (select(purchases)..where((x) => x.id.equals(id))).getSingleOrNull();

  Future<int> createPurchase(
    PurchasesCompanion value, {
    int initialAmount = 0,
    required String paymentDate,
    required String paymentMethod,
  }) => transaction(() async {
    final purchaseId = await into(purchases).insert(value);
    if (initialAmount > 0) {
      await into(payments).insert(
        PaymentsCompanion.insert(
          purchaseId: purchaseId,
          paymentDate: paymentDate,
          amount: initialAmount,
          paymentMethod: paymentMethod,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
    }
    return purchaseId;
  });

  Future<void> updatePurchase(PurchaseRow value) async {
    final paid = await paidFor(value.id);
    if (value.totalAmount < paid) {
      throw const LocalDataException('課程總額不可小於目前已付款金額');
    }
    await update(purchases).replace(value);
  }

  Future<void> deletePurchase(int id) => transaction(() async {
    await (delete(purchases)..where((x) => x.id.equals(id))).go();
  });
  Future<int> addPayment(PaymentsCompanion value) async {
    final purchase = await find(value.purchaseId.value);
    if (purchase == null) throw const LocalDataException('找不到購課紀錄');
    final paid = await paidFor(purchase.id);
    if (paid + value.amount.value > purchase.totalAmount) {
      throw const LocalDataException('付款金額不可超過尚欠金額');
    }
    return into(payments).insert(value);
  }

  Future<void> updatePayment(PaymentRow value) async {
    final purchase = await find(value.purchaseId);
    if (purchase == null) throw const LocalDataException('找不到購課紀錄');
    final other = await paidFor(value.purchaseId, excludingPaymentId: value.id);
    if (other + value.amount > purchase.totalAmount) {
      throw const LocalDataException('付款金額不可超過尚欠金額');
    }
    await update(payments).replace(value);
  }

  Future<int> deletePayment(int id) =>
      (delete(payments)..where((x) => x.id.equals(id))).go();
}

class LocalDataException implements Exception {
  final String message;
  const LocalDataException(this.message);
  @override
  String toString() => message;
}
