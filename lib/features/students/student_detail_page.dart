import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class StudentDetailPage extends ConsumerStatefulWidget {
  final int id;
  const StudentDetailPage({super.key, required this.id});
  @override
  ConsumerState<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends ConsumerState<StudentDetailPage> {
  int tab = 0;
  Future<void> edit(StudentDetail d) async {
    final data = await showStudentForm(context, detail: d);
    if (data == null) return;
    try {
      await ref.read(studentRepositoryProvider).update(d.id, data);
      refreshBusinessData(ref);
      if (mounted) showMessage(context, '修改成功');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> addLesson() async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      if (!mounted) return;
      final data = await showLessonForm(
        context,
        students: students,
        studentId: widget.id,
      );
      if (data == null) return;
      final result = await ref.read(lessonRepositoryProvider).create(data);
      refreshBusinessData(ref);
      if (mounted) {
        showMessage(context, '新增成功');
        if (result.warning?.isNotEmpty == true) {
          showMessage(context, result.warning!);
        }
      }
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> addPurchase() async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      final packages = await ref.read(packagesProvider.future);
      if (!mounted) return;
      final data = await showPurchaseForm(
        context,
        students: students,
        packages: packages,
        studentId: widget.id,
      );
      if (data == null) return;
      await ref.read(purchaseRepositoryProvider).create(data);
      refreshBusinessData(ref);
      if (mounted) showMessage(context, '新增成功');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentDetailProvider(widget.id));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () => context.go('/students'),
          icon: const Icon(Icons.arrow_back),
          label: const Text('返回學員列表'),
        ),
        const SizedBox(height: 8),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(studentDetailProvider(widget.id)),
          ),
          data: (d) => _body(d),
        ),
      ],
    );
  }

  Widget _body(StudentDetail d) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PageTitle(
        d.name,
        '${d.phone ?? '未填電話'} · 加入日期 ${uiDate(d.joinDate)}',
        action: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => edit(d),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('編輯資料'),
            ),
            OutlinedButton.icon(
              onPressed: addLesson,
              icon: const Icon(Icons.add),
              label: const Text('新增上課'),
            ),
            ElevatedButton.icon(
              onPressed: addPurchase,
              icon: const Icon(Icons.add),
              label: const Text('新增購課'),
            ),
          ],
        ),
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          StatusChip(
            d.isActive ? '啟用' : '停用',
            d.isActive ? Colors.green : Colors.grey,
          ),
          if (d.statistics.remainingLessons <= 2)
            const StatusChip('剩餘堂數不足', Colors.orange),
        ],
      ),
      const SizedBox(height: 18),
      KpiGrid(
        children: [
          KpiCard(
            label: '累計購買堂數',
            value: '${d.statistics.totalPurchasedLessons} 堂',
            icon: Icons.shopping_bag_outlined,
          ),
          KpiCard(
            label: '已使用堂數',
            value: '${d.statistics.usedLessons} 堂',
            icon: Icons.fact_check_outlined,
          ),
          KpiCard(
            label: '剩餘堂數',
            value: '${d.statistics.remainingLessons} 堂',
            icon: Icons.menu_book_outlined,
          ),
          KpiCard(
            label: '待收款',
            value: money(d.statistics.outstandingAmount),
            icon: Icons.account_balance_wallet_outlined,
          ),
        ],
      ),
      const SizedBox(height: 22),
      SegmentedButton<int>(
        segments: const [
          ButtonSegment(value: 0, label: Text('基本資料')),
          ButtonSegment(value: 1, label: Text('上課紀錄')),
          ButtonSegment(value: 2, label: Text('購課紀錄')),
        ],
        selected: {tab},
        onSelectionChanged: (v) => setState(() => tab = v.first),
      ),
      const SizedBox(height: 14),
      if (tab == 0)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 60,
              runSpacing: 24,
              children: [
                _info('姓名', d.name),
                _info('電話', d.phone ?? '—'),
                _info('加入日期', uiDate(d.joinDate)),
                _info('狀態', d.isActive ? '啟用' : '停用'),
                _info('備註', d.note ?? '—'),
              ],
            ),
          ),
        ),
      if (tab == 1)
        d.recentLessons.isEmpty
            ? const EmptyState()
            : ResponsiveTable(
                columns: const [
                  DataColumn(label: Text('日期')),
                  DataColumn(label: Text('狀態')),
                  DataColumn(label: Text('課程內容')),
                  DataColumn(label: Text('身體狀況')),
                  DataColumn(label: Text('備註')),
                ],
                rows: d.recentLessons
                    .map(
                      (x) => DataRow(
                        cells: [
                          DataCell(Text(uiDate(x.lessonDate))),
                          DataCell(StatusChip.lesson(x.status)),
                          DataCell(Text(x.content ?? '—')),
                          DataCell(Text(x.physicalCondition ?? '—')),
                          DataCell(Text(x.note ?? '—')),
                        ],
                      ),
                    )
                    .toList(),
              ),
      if (tab == 2)
        d.purchases.isEmpty
            ? const EmptyState()
            : ResponsiveTable(
                columns: const [
                  DataColumn(label: Text('日期')),
                  DataColumn(label: Text('方案')),
                  DataColumn(label: Text('堂數')),
                  DataColumn(label: Text('總額')),
                  DataColumn(label: Text('已付款')),
                  DataColumn(label: Text('待付款')),
                  DataColumn(label: Text('操作')),
                ],
                rows: d.purchases
                    .map(
                      (x) => DataRow(
                        cells: [
                          DataCell(Text(uiDate(x.purchaseDate))),
                          DataCell(Text(x.packageName)),
                          DataCell(Text('${x.purchasedLessons}')),
                          DataCell(Text(money(x.totalAmount))),
                          DataCell(Text(money(x.paidAmount))),
                          DataCell(Text(money(x.outstandingAmount))),
                          DataCell(
                            TextButton(
                              onPressed: () => context.go('/purchases'),
                              child: const Text('查看收款'),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
    ],
  );
  Widget _info(String label, String value) => SizedBox(
    width: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Text(value),
      ],
    ),
  );
}
