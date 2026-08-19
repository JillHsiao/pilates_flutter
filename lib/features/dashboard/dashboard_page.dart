import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});
  Future<void> _lesson(BuildContext context, WidgetRef ref) async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      if (!context.mounted) return;
      final data = await showLessonForm(context, students: students);
      if (data == null) return;
      final result = await ref.read(lessonRepositoryProvider).create(data);
      refreshBusinessData(ref);
      if (context.mounted) {
        showMessage(context, '新增成功');
        if (result.warning?.isNotEmpty == true) {
          showMessage(context, result.warning!);
        }
      }
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> _purchase(BuildContext context, WidgetRef ref) async {
    try {
      final values = await Future.wait([
        ref.read(allStudentsProvider.future),
        ref.read(packagesProvider.future),
      ]);
      if (!context.mounted) return;
      final data = await showPurchaseForm(
        context,
        students: values[0] as List<Student>,
        packages: values[1] as List<CoursePackage>,
      );
      if (data == null) return;
      await ref.read(purchaseRepositoryProvider).create(data);
      refreshBusinessData(ref);
      if (context.mounted) showMessage(context, '新增成功');
    } catch (e) {
      if (context.mounted) showMessage(context, errorText(e), error: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          '儀表板',
          '今天也從清楚掌握每位學員開始。',
          action: Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _lesson(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('新增上課'),
              ),
              ElevatedButton.icon(
                onPressed: () => _purchase(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('新增購課'),
              ),
            ],
          ),
        ),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(dashboardProvider),
          ),
          data: (d) => _DashboardBody(d),
        ),
      ],
    );
  }
}

class _DashboardBody extends StatelessWidget {
  final DashboardData d;
  const _DashboardBody(this.d);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      KpiGrid(
        children: [
          KpiCard(
            label: '本月營收',
            value: money(d.monthlyRevenue),
            icon: Icons.payments_outlined,
          ),
          KpiCard(
            label: '本月已上課堂數',
            value: '${d.monthlyCompletedLessons} 堂',
            icon: Icons.fact_check_outlined,
          ),
          KpiCard(
            label: '有效學員',
            value: '${d.activeStudents} 位',
            icon: Icons.people_outline,
          ),
          KpiCard(
            label: '待收款',
            value: money(d.outstandingAmount),
            icon: Icons.account_balance_wallet_outlined,
          ),
        ],
      ),
      const SizedBox(height: 22),
      LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth >= 950;
          final charts = [
            _ChartCard(title: '月營收趨勢', child: _BarTrend(d.revenueTrend)),
            _ChartCard(title: '每月上課堂數', child: _LineTrend(d.lessonTrend)),
          ];
          return wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: charts[0]),
                    const SizedBox(width: 18),
                    Expanded(child: charts[1]),
                  ],
                )
              : Column(
                  children: [charts[0], const SizedBox(height: 18), charts[1]],
                );
        },
      ),
      const SizedBox(height: 22),
      LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth >= 950;
          final lists = [
            _LowLessons(d.lowLessonStudents),
            _RecentLessons(d.recentLessons),
          ];
          return wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: lists[0]),
                    const SizedBox(width: 18),
                    Expanded(child: lists[1]),
                  ],
                )
              : Column(
                  children: [lists[0], const SizedBox(height: 18), lists[1]],
                );
        },
      ),
    ],
  );
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartCard({required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          SizedBox(height: 260, child: child),
        ],
      ),
    ),
  );
}

class _BarTrend extends StatelessWidget {
  final List<TrendPoint> data;
  const _BarTrend(this.data);
  @override
  Widget build(BuildContext context) => BarChart(
    BarChartData(
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(drawVerticalLine: false),
      titlesData: _titles(data),
      barGroups: [
        for (var i = 0; i < data.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: data[i].value.toDouble(),
                color: Theme.of(context).colorScheme.primary,
                width: 16,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(5),
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

class _LineTrend extends StatelessWidget {
  final List<TrendPoint> data;
  const _LineTrend(this.data);
  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(drawVerticalLine: false),
      titlesData: _titles(data),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var i = 0; i < data.length; i++)
              FlSpot(i.toDouble(), data[i].value.toDouble()),
          ],
          color: const Color(0xFFB7794D),
          barWidth: 3,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    ),
  );
}

FlTitlesData _titles(List<TrendPoint> data) => FlTitlesData(
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 32,
      getTitlesWidget: (value, meta) {
        final i = value.toInt();
        if (i < 0 || i >= data.length || i % 2 == 1) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            data[i].month.substring(5),
            style: const TextStyle(fontSize: 11),
          ),
        );
      },
    ),
  ),
  leftTitles: const AxisTitles(
    sideTitles: SideTitles(showTitles: true, reservedSize: 42),
  ),
);

class _LowLessons extends StatelessWidget {
  final List<LowLessonStudent> data;
  const _LowLessons(this.data);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '堂數不足學員',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          if (data.isEmpty)
            const Padding(
              padding: EdgeInsets.all(28),
              child: Center(child: Text('目前沒有堂數不足的學員')),
            )
          else
            ...data.map(
              (s) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: TextButton(
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                  onPressed: () => context.go('/students/${s.id}'),
                  child: Text(s.name),
                ),
                subtitle: Text('最近上課 ${uiDate(s.lastLessonDate)}'),
                trailing: StatusChip(
                  '${s.remainingLessons} 堂',
                  s.remainingLessons <= 0 ? Colors.red : Colors.orange,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _RecentLessons extends StatelessWidget {
  final List<Lesson> data;
  const _RecentLessons(this.data);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '最近上課紀錄',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          if (data.isEmpty)
            const Padding(
              padding: EdgeInsets.all(28),
              child: Center(child: Text('目前沒有資料')),
            )
          else
            ...data.map(
              (x) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(x.studentName),
                subtitle: Text(uiDate(x.lessonDate)),
                trailing: StatusChip.lesson(x.status),
              ),
            ),
        ],
      ),
    ),
  );
}
