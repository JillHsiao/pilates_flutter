import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  int tab = 0;

  Future<void> backup() async {
    try {
      await ref.read(backupServiceProvider).backupAndShare();
      ref.invalidate(lastBackupProvider);
      if (mounted) showMessage(context, '備份已建立');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> restore() async {
    try {
      final selection = await ref.read(backupServiceProvider).pickBackup();
      if (selection == null || !mounted) return;
      final ok = await confirmDelete(
        context,
        title: '還原本機資料',
        message: '還原會以所選備份取代目前所有資料。確定繼續？',
      );
      if (!ok) return;
      await ref.read(backupServiceProvider).restore(selection.data);
      refreshBusinessData(ref);
      ref.invalidate(packagesProvider);
      ref.invalidate(lastBackupProvider);
      if (mounted) showMessage(context, '資料還原完成');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> exportCsv() async {
    try {
      await ref.read(backupServiceProvider).exportCsvAndShare();
      if (mounted) showMessage(context, 'CSV 已匯出');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> save([CoursePackage? package]) async {
    final data = await showPackageForm(context, initial: package);
    if (data == null) return;
    try {
      final repo = ref.read(packageRepositoryProvider);
      package == null
          ? await repo.create(data)
          : await repo.update(package.id, data);
      ref.invalidate(packagesProvider);
      if (mounted) showMessage(context, package == null ? '新增成功' : '修改成功');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> deactivatePackage(CoursePackage package) async {
    final ok = await confirmDelete(
      context,
      title: '停用課程方案',
      message: '確定停用「${package.name}」？既有購課紀錄不會受到影響。',
    );
    if (!ok) return;
    try {
      await ref.read(packageRepositoryProvider).deactivate(package.id);
      ref.invalidate(packagesProvider);
      if (mounted) showMessage(context, '方案已停用');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages = ref.watch(packagesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitle('系統設定', '管理可銷售方案與檢視固定選項。'),
        _SettingsTabs(
          selected: tab,
          onChanged: (value) => setState(() => tab = value),
        ),
        const SizedBox(height: 18),
        if (tab == 0)
          packages.when(
            loading: () => const LoadingState(),
            error: (e, _) => ErrorState(
              error: e,
              onRetry: () => ref.invalidate(packagesProvider),
            ),
            data: (data) => Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => save(),
                    icon: const Icon(Icons.add),
                    label: const Text('新增方案'),
                  ),
                ),
                const SizedBox(height: 12),
                if (data.isEmpty)
                  const EmptyState()
                else
                  ResponsiveTable(
                    minWidth: 720,
                    columns: const [
                      DataColumn(label: Text('名稱')),
                      DataColumn(label: Text('堂數'), numeric: true),
                      DataColumn(label: Text('售價'), numeric: true),
                      DataColumn(label: Text('狀態')),
                      DataColumn(label: Text('排序'), numeric: true),
                      DataColumn(label: Text('操作')),
                    ],
                    rows: data
                        .map(
                          (p) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  p.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              DataCell(Text('${p.lessons}')),
                              DataCell(Text(money(p.price))),
                              DataCell(
                                StatusChip(
                                  p.isActive ? '啟用' : '停用',
                                  p.isActive ? Colors.green : Colors.grey,
                                ),
                              ),
                              DataCell(Text('${p.sortOrder}')),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      tooltip: '編輯',
                                      onPressed: () => save(p),
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    if (p.isActive)
                                      IconButton(
                                        tooltip: '停用',
                                        color: Colors.orange.shade800,
                                        onPressed: () => deactivatePackage(p),
                                        icon: const Icon(
                                          Icons.power_settings_new,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        if (tab == 1)
          const _Fixed(
            title: '付款方式',
            items: ['現金', '轉帳', 'LINE Pay', '信用卡', '其他'],
          ),
        if (tab == 2)
          const _Fixed(
            title: '上課狀態',
            items: ['已上課（扣堂）', '請假（不扣堂）', '取消（不扣堂）', '補課（暫不扣堂）'],
          ),
        if (tab == 3)
          _DataManagement(
            lastBackup: ref.watch(lastBackupProvider),
            onBackup: backup,
            onRestore: restore,
            onExportCsv: exportCsv,
          ),
      ],
    );
  }
}

class _SettingsTabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _SettingsTabs({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 44,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<int>(
        style: const ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(122, 44)),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 14)),
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(value: 0, label: Center(child: Text('課程方案'))),
          ButtonSegment(value: 1, label: Center(child: Text('付款方式'))),
          ButtonSegment(value: 2, label: Center(child: Text('上課狀態'))),
          ButtonSegment(value: 3, label: Center(child: Text('資料管理'))),
        ],
        selected: {selected},
        onSelectionChanged: (values) => onChanged(values.first),
      ),
    ),
  );
}

class _DataManagement extends StatelessWidget {
  final AsyncValue<DateTime?> lastBackup;
  final VoidCallback onBackup;
  final VoidCallback onRestore;
  final VoidCallback onExportCsv;

  const _DataManagement({
    required this.lastBackup,
    required this.onBackup,
    required this.onRestore,
    required this.onExportCsv,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '離線資料管理',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            '資料目前儲存在此裝置的瀏覽器中。\n\n'
            '如果清除 Safari 網站資料、重設瀏覽器資料或更換裝置，'
            '本機資料可能遺失。\n\n請定期備份。',
          ),
          const SizedBox(height: 10),
          lastBackup.when(
            loading: () => const Text('正在檢查最近備份…'),
            error: (_, _) => const Text('無法取得最近備份時間'),
            data: (date) => Text(
              date == null
                  ? '尚未建立備份'
                  : '最近備份：${DateFormat('yyyy/MM/dd HH:mm').format(date)}',
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: onBackup,
                icon: const Icon(Icons.backup_outlined),
                label: const Text('立即備份'),
              ),
              OutlinedButton.icon(
                onPressed: onRestore,
                icon: const Icon(Icons.restore),
                label: const Text('從 JSON 還原'),
              ),
              OutlinedButton.icon(
                onPressed: onExportCsv,
                icon: const Icon(Icons.table_view_outlined),
                label: const Text('匯出 CSV'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _Fixed extends StatelessWidget {
  final String title;
  final List<String> items;
  const _Fixed({required this.title, required this.items});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text('此為系統固定選項，目前不可刪除。'),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items
                .map(
                  (x) => Container(
                    width: 220,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      x,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}
