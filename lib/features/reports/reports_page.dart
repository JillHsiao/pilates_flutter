import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});
  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  late String from = '${DateTime.now().year}-01-01',
      to = '${DateTime.now().year}-12-31';
  ReportQuery get query => (from: from, to: to);
  Future<void> pick(bool start) async {
    final chosen = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(start ? from : to),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (chosen != null) {
      setState(() {
        if (start) {
          from = apiDate(chosen);
        } else {
          to = apiDate(chosen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportProvider(query));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitle('營收統計', '以實際收款日呈現營收，避免應收與實收混淆。'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => pick(true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '開始日期',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      child: Text(uiDate(from)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => pick(false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '結束日期',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      child: Text(uiDate(to)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(reportProvider(query)),
          ),
          data: _body,
        ),
      ],
    );
  }

  Widget _body(ReportData d) => Column(
    children: [
      KpiGrid(
        maxColumns: 2,
        children: [
          KpiCard(
            label: '實收營收',
            value: money(d.revenue),
            icon: Icons.payments_outlined,
          ),
          KpiCard(
            label: '已上課堂數',
            value: '${d.completedLessons}',
            icon: Icons.fact_check_outlined,
          ),
          KpiCard(
            label: '購買堂數',
            value: '${d.purchasedLessons}',
            icon: Icons.shopping_bag_outlined,
          ),
          KpiCard(
            label: '新增學員',
            value: '${d.newStudents}',
            icon: Icons.person_add_alt,
          ),
        ],
      ),
      const SizedBox(height: 22),
      _ReportChart('月營收', d.months, revenue: true),
      const SizedBox(height: 18),
      _ReportChart('月上課堂數', d.months, revenue: false),
      const SizedBox(height: 22),
      ResponsiveTable(
        columns: const [
          DataColumn(label: Text('月份')),
          DataColumn(label: Text('營收')),
          DataColumn(label: Text('已上課堂數')),
          DataColumn(label: Text('購買堂數')),
          DataColumn(label: Text('新增學員')),
        ],
        rows: d.months
            .map(
              (m) => DataRow(
                cells: [
                  DataCell(Text(m.month)),
                  DataCell(Text(money(m.revenue))),
                  DataCell(Text('${m.completedLessons}')),
                  DataCell(Text('${m.purchasedLessons}')),
                  DataCell(Text('${m.newStudents}')),
                ],
              ),
            )
            .toList(),
      ),
    ],
  );
}

class _ReportChart extends StatelessWidget {
  final String title;
  final List<MonthlyReportRow> data;
  final bool revenue;
  const _ReportChart(this.title, this.data, {required this.revenue});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 270,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 2),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 52,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (v, m) {
                          final i = v.toInt();
                          return i >= 0 && i < data.length
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    data[i].month.substring(5),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < data.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: revenue
                                ? data[i].revenue.toDouble()
                                : data[i].completedLessons.toDouble(),
                            color: revenue
                                ? Theme.of(context).colorScheme.primary
                                : const Color(0xFFB7794D),
                            width: 18,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
