import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates_flutter/app/theme.dart';
import 'package:pilates_flutter/widgets/app_shell.dart';
import 'package:pilates_flutter/widgets/common.dart';

Widget testApp() {
  final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => AppShell(
          child: Column(
            children: [
              const KpiGrid(
                children: [
                  KpiCard(
                    label: '本月營收',
                    value: 'NT\$1,900',
                    icon: Icons.payments_outlined,
                  ),
                  KpiCard(
                    label: '已上課',
                    value: '12 堂',
                    icon: Icons.fact_check_outlined,
                  ),
                  KpiCard(
                    label: '有效學員',
                    value: '8 位',
                    icon: Icons.people_outline,
                  ),
                  KpiCard(
                    label: '待收款',
                    value: 'NT\$16,000',
                    icon: Icons.wallet_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ResponsiveTable(
                minWidth: 1100,
                columns: const [
                  DataColumn(label: Text('日期')),
                  DataColumn(label: Text('學員')),
                  DataColumn(label: Text('方案')),
                  DataColumn(label: Text('總額')),
                  DataColumn(label: Text('操作')),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('2026/08/18')),
                      DataCell(Text('蕭宇筑')),
                      DataCell(Text('10堂')),
                      DataCell(Text('NT\$17,000')),
                      DataCell(Text('編輯')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
  return MaterialApp.router(theme: buildAppTheme(), routerConfig: router);
}

void main() {
  for (final size in [
    const Size(1024, 768),
    const Size(1180, 820),
    const Size(1366, 1024),
  ]) {
    testWidgets(
      'tablet landscape ${size.width.toInt()}x${size.height.toInt()} has rail and no overflow',
      (tester) async {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(testApp());
        await tester.pumpAndSettle();
        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.text('本月營收'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.binding.setSurfaceSize(null);
      },
    );
  }

  for (final size in [const Size(600, 900), const Size(768, 1024)]) {
    testWidgets(
      'portrait ${size.width.toInt()}x${size.height.toInt()} uses drawer navigation',
      (tester) async {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(testApp());
        await tester.pumpAndSettle();
        expect(find.byType(NavigationRail), findsNothing);
        expect(find.byTooltip('Open navigation menu'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.binding.setSurfaceSize(null);
      },
    );
  }
}
