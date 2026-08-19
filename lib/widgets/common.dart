import 'package:flutter/material.dart';
import '../core/utils/formatters.dart';

class PageTitle extends StatelessWidget {
  final String title, subtitle;
  final Widget? action;
  const PageTitle(this.title, this.subtitle, {super.key, this.action});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
          ],
        );
        if (action == null) return heading;
        if (constraints.maxWidth < 620) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heading,
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: action!),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: heading),
            const SizedBox(width: 20),
            action!,
          ],
        );
      },
    ),
  );
}

class KpiCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) => Card(
    child: SizedBox(
      height: 118,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(icon, color: Theme.of(context).colorScheme.primary),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ),
  );
}

class KpiGrid extends StatelessWidget {
  final List<Widget> children;
  final int maxColumns;
  const KpiGrid({super.key, required this.children, this.maxColumns = 4});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final responsiveCols = c.maxWidth >= 1100
          ? 4
          : c.maxWidth >= 600
          ? 2
          : 1;
      final cols = responsiveCols > maxColumns ? maxColumns : responsiveCols;
      final width = (c.maxWidth - (cols - 1) * 14) / cols;
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: children
            .map((x) => SizedBox(width: width, child: x))
            .toList(),
      );
    },
  );
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});
  @override
  Widget build(BuildContext context) => const Card(
    child: SizedBox(
      height: 220,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('資料載入中…'),
          ],
        ),
      ),
    ),
  );
}

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, this.message = '目前沒有資料'});
  @override
  Widget build(BuildContext context) => Card(
    child: SizedBox(
      height: 180,
      child: Center(
        child: Text(message, style: TextStyle(color: Colors.grey.shade500)),
      ),
    ),
  );
}

class ErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  const ErrorState({super.key, required this.error, required this.onRetry});
  @override
  Widget build(BuildContext context) => Card(
    child: SizedBox(
      height: 220,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 34),
            const SizedBox(height: 10),
            Text(errorText(error), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('重新載入'),
            ),
          ],
        ),
      ),
    ),
  );
}

class ResponsiveTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final double minWidth;
  final double columnSpacing;
  final double horizontalMargin;
  const ResponsiveTable({
    super.key,
    required this.columns,
    required this.rows,
    this.minWidth = 760,
    this.columnSpacing = 24,
    this.horizontalMargin = 18,
  });
  @override
  Widget build(BuildContext context) => Card(
    child: LayoutBuilder(
      builder: (context, c) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: c.maxWidth > minWidth ? c.maxWidth : minWidth,
          ),
          child: DataTable(
            headingRowColor: WidgetStatePropertyAll(Colors.grey.shade50),
            columnSpacing: columnSpacing,
            horizontalMargin: horizontalMargin,
            headingRowHeight: 54,
            dataRowMinHeight: 54,
            dataRowMaxHeight: 62,
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    ),
  );
}

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const StatusChip(this.label, this.color, {super.key});
  factory StatusChip.lesson(String status) {
    final color = status == 'Completed'
        ? Colors.green
        : status == 'Leave'
        ? Colors.orange
        : status == 'Cancelled'
        ? Colors.red
        : Colors.blueGrey;
    return StatusChip(lessonLabels[status] ?? status, color);
  }
  factory StatusChip.payment(String status) {
    final color = status == 'Paid'
        ? Colors.green
        : status == 'Partial'
        ? Colors.orange
        : Colors.red;
    final label = status == 'Paid'
        ? '已付清'
        : status == 'Partial'
        ? '部分付款'
        : '未付款';
    return StatusChip(label, color);
  }
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

String errorText(Object error) {
  return error.toString().replaceFirst('Exception: ', '');
}

void showMessage(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red.shade700 : null,
    ),
  );
}

Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  required String message,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('確認刪除'),
          ),
        ],
      ),
    ) ??
    false;

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  const DateField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    readOnly: true,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: const Icon(Icons.calendar_month),
    ),
    onTap: () async {
      final initial = DateTime.tryParse(controller.text) ?? DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) controller.text = apiDate(picked);
    },
  );
}
