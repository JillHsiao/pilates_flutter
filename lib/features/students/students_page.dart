import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});
  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  String search = '';
  bool? active;
  int page = 1;
  StudentQuery get query => (search: search, active: active, page: page);
  Future<void> save({Student? student}) async {
    final data = await showStudentForm(context, student: student);
    if (data == null) return;
    try {
      final repo = ref.read(studentRepositoryProvider);
      student == null
          ? await repo.create(data)
          : await repo.update(student.id, data);
      ref.invalidate(studentsProvider);
      ref.invalidate(allStudentsProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) showMessage(context, student == null ? '新增成功' : '修改成功');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentsProvider(query));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          '學員管理',
          '查看堂數、收款與學員狀態。',
          action: ElevatedButton.icon(
            onPressed: () => save(),
            icon: const Icon(Icons.add),
            label: const Text('新增學員'),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final searchField = TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: '搜尋姓名或電話',
                  ),
                  onChanged: (v) => setState(() {
                    search = v;
                    page = 1;
                  }),
                );
                final statusField = DropdownButtonFormField<bool?>(
                  initialValue: active,
                  decoration: const InputDecoration(labelText: '狀態'),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('全部狀態')),
                    DropdownMenuItem(value: true, child: Text('啟用')),
                    DropdownMenuItem(value: false, child: Text('已停用')),
                  ],
                  onChanged: (v) => setState(() {
                    active = v;
                    page = 1;
                  }),
                );
                if (constraints.maxWidth < 560) {
                  return Column(
                    children: [
                      searchField,
                      const SizedBox(height: 12),
                      statusField,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 2, child: searchField),
                    const SizedBox(width: 12),
                    Expanded(child: statusField),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 18),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(studentsProvider(query)),
          ),
          data: (d) => Column(
            children: [
              if (d.items.isEmpty)
                const EmptyState(message: '找不到符合條件的學員')
              else
                ResponsiveTable(
                  minWidth: 860,
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text('姓名')),
                    DataColumn(label: Text('電話')),
                    DataColumn(label: Text('加入日期')),
                    DataColumn(label: Text('購買'), numeric: true),
                    DataColumn(label: Text('已使用'), numeric: true),
                    DataColumn(label: Text('剩餘'), numeric: true),
                    DataColumn(label: Text('待收款'), numeric: true),
                    DataColumn(label: Text('狀態')),
                    DataColumn(label: Text('操作')),
                  ],
                  rows: d.items
                      .map(
                        (s) => DataRow(
                          cells: [
                            DataCell(
                              TextButton(
                                onPressed: () =>
                                    context.go('/students/${s.id}'),
                                child: Text(s.name),
                              ),
                            ),
                            DataCell(Text(s.phone ?? '—')),
                            DataCell(Text(uiDate(s.joinDate))),
                            DataCell(Text('${s.totalPurchasedLessons}')),
                            DataCell(Text('${s.usedLessons}')),
                            DataCell(
                              SizedBox(
                                width: 44,
                                child: Center(
                                  child: s.remainingLessons <= 2
                                      ? StatusChip(
                                          '${s.remainingLessons}',
                                          Colors.orange,
                                        )
                                      : Text('${s.remainingLessons}'),
                                ),
                              ),
                            ),
                            DataCell(Text(money(s.outstandingAmount))),
                            DataCell(
                              StatusChip(
                                s.isActive ? '啟用' : '停用',
                                s.isActive ? Colors.green : Colors.grey,
                              ),
                            ),
                            DataCell(
                              IconButton(
                                tooltip: '編輯',
                                onPressed: () => save(student: s),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('共 ${d.totalCount} 位'),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: page > 1
                              ? () => setState(() => page--)
                              : null,
                          child: const Text('上一頁'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: page < d.totalPages
                              ? () => setState(() => page++)
                              : null,
                          child: const Text('下一頁'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
