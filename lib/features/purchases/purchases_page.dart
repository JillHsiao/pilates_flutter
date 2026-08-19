import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class PurchasesPage extends ConsumerWidget {
  const PurchasesPage({super.key});
  Future<void> create(BuildContext context, WidgetRef ref) async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      final packages = await ref.read(packagesProvider.future);
      if (!context.mounted) return;
      final data = await showPurchaseForm(
        context,
        students: students,
        packages: packages,
      );
      if (data == null) return;
      await ref.read(purchaseRepositoryProvider).create(data);
      refreshBusinessData(ref);
      if (context.mounted) showMessage(context, '新增成功');
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> edit(
    BuildContext context,
    WidgetRef ref,
    Purchase purchase,
  ) async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      final packages = await ref.read(packagesProvider.future);
      if (!context.mounted) return;
      final data = await showPurchaseForm(
        context,
        students: students,
        packages: packages,
        initial: purchase,
      );
      if (data == null) return;
      await ref.read(purchaseRepositoryProvider).update(purchase.id, data);
      refreshBusinessData(ref);
      if (context.mounted) showMessage(context, '修改成功');
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> deletePurchase(
    BuildContext context,
    WidgetRef ref,
    Purchase purchase,
  ) async {
    final ok = await confirmDelete(
      context,
      title: '刪除購課',
      message: '此操作會一併刪除該筆購課底下的所有付款紀錄，且無法復原。',
    );
    if (!ok) return;
    try {
      await ref.read(purchaseRepositoryProvider).delete(purchase.id);
      refreshBusinessData(ref);
      if (context.mounted) showMessage(context, '購課紀錄已刪除');
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> payment(
    BuildContext context,
    WidgetRef ref,
    Purchase purchase, [
    Payment? initial,
  ]) async {
    final data = await showPaymentForm(
      context,
      purchase: purchase,
      initial: initial,
    );
    if (data == null) return;
    try {
      final repo = ref.read(purchaseRepositoryProvider);
      initial == null
          ? await repo.addPayment(purchase.id, data)
          : await repo.updatePayment(initial.id, data);
      refreshBusinessData(ref);
      if (context.mounted) {
        showMessage(context, initial == null ? '付款新增成功' : '修改成功');
      }
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> deletePayment(
    BuildContext context,
    WidgetRef ref,
    Payment payment,
  ) async {
    final ok = await confirmDelete(
      context,
      title: '刪除付款紀錄',
      message: '刪除後待收款會立即重新計算，確定繼續？',
    );
    if (!ok) return;
    try {
      await ref.read(purchaseRepositoryProvider).deletePayment(payment.id);
      refreshBusinessData(ref);
      if (context.mounted) showMessage(context, '刪除成功');
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(purchasesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          '購課 / 收款',
          '追蹤購課快照、分期付款與尚欠金額。',
          action: ElevatedButton.icon(
            onPressed: () => create(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('新增購課'),
          ),
        ),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(purchasesProvider),
          ),
          data: (data) => data.isEmpty
              ? const EmptyState()
              : _PurchaseTable(
                  data: data,
                  edit: (p) => edit(context, ref, p),
                  remove: (p) => deletePurchase(context, ref, p),
                  pay: (p) => payment(context, ref, p),
                  editPayment: (p, x) => payment(context, ref, p, x),
                  removePayment: (x) => deletePayment(context, ref, x),
                ),
        ),
      ],
    );
  }
}

class _PurchaseTable extends StatelessWidget {
  final List<Purchase> data;
  final ValueChanged<Purchase> edit, remove, pay;
  final void Function(Purchase, Payment) editPayment;
  final ValueChanged<Payment> removePayment;
  const _PurchaseTable({
    required this.data,
    required this.edit,
    required this.remove,
    required this.pay,
    required this.editPayment,
    required this.removePayment,
  });
  @override
  Widget build(BuildContext context) => Card(
    child: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: constraints.maxWidth < 1010 ? 1010 : constraints.maxWidth,
          child: Column(
            children: [
              const _Header(),
              ...data.map(
                (p) => _PurchaseRow(
                  p: p,
                  edit: () => edit(p),
                  remove: () => remove(p),
                  pay: () => pay(p),
                  editPayment: (x) => editPayment(p, x),
                  removePayment: removePayment,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.grey.shade50,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    child: const Row(
      children: [
        SizedBox(width: 44),
        _Cell('購買日期', 96),
        _Cell('學員', 100),
        _Cell('方案', 100),
        _Cell('堂數', 56, numeric: true),
        _Cell('總額', 96, numeric: true),
        _Cell('已付款', 96, numeric: true),
        _Cell('未付款', 96, numeric: true),
        _Cell('狀態', 90),
        Expanded(
          child: Text('操作', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}

class _PurchaseRow extends StatefulWidget {
  final Purchase p;
  final VoidCallback edit, remove, pay;
  final ValueChanged<Payment> editPayment, removePayment;
  const _PurchaseRow({
    required this.p,
    required this.edit,
    required this.remove,
    required this.pay,
    required this.editPayment,
    required this.removePayment,
  });
  @override
  State<_PurchaseRow> createState() => _PurchaseRowState();
}

class _PurchaseRowState extends State<_PurchaseRow> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFF0EEEC))),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                child: IconButton(
                  onPressed: () => setState(() => open = !open),
                  icon: Icon(open ? Icons.expand_less : Icons.expand_more),
                ),
              ),
              _Cell(uiDate(p.purchaseDate), 96),
              _Cell(p.studentName, 100),
              _Cell(p.packageName, 100),
              _Cell('${p.purchasedLessons}', 56, numeric: true),
              _Cell(money(p.totalAmount), 96, numeric: true),
              _Cell(money(p.paidAmount), 96, numeric: true),
              _Cell(money(p.outstandingAmount), 96, numeric: true),
              SizedBox(
                width: 90,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StatusChip.payment(p.paymentStatus),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: '編輯購課',
                      onPressed: widget.edit,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      tooltip: '刪除購課',
                      color: Colors.red,
                      onPressed: widget.remove,
                      icon: const Icon(Icons.delete_outline),
                    ),
                    OutlinedButton.icon(
                      onPressed: p.outstandingAmount > 0 ? widget.pay : null,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('新增付款'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (open)
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.fromLTRB(56, 14, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '付款紀錄',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                if (p.payments.isEmpty)
                  const Text('尚無付款', style: TextStyle(color: Colors.grey))
                else
                  ...p.payments.map(
                    (x) => Card(
                      child: ListTile(
                        title: Text(
                          '${uiDate(x.paymentDate)} · ${paymentLabels[x.paymentMethod] ?? x.paymentMethod} · ${money(x.amount)}',
                        ),
                        subtitle: x.note?.isNotEmpty == true
                            ? Text(x.note!)
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: '編輯付款',
                              onPressed: () => widget.editPayment(x),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              tooltip: '刪除付款',
                              color: Colors.red,
                              onPressed: () => widget.removePayment(x),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;
  final double width;
  final bool numeric;
  const _Cell(this.text, this.width, {this.numeric = false});
  @override
  Widget build(BuildContext context) => Container(
    width: width,
    alignment: numeric ? Alignment.centerRight : Alignment.centerLeft,
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: numeric ? TextAlign.right : TextAlign.left,
      style: const TextStyle(fontSize: 13),
    ),
  );
}
