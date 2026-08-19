import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme.dart';

const _destinations = [
  ('儀表板', Icons.dashboard_outlined, '/dashboard'),
  ('學員管理', Icons.people_outline, '/students'),
  ('上課紀錄', Icons.fact_check_outlined, '/lessons'),
  ('購課 / 收款', Icons.credit_card_outlined, '/purchases'),
  ('營收統計', Icons.bar_chart_outlined, '/reports'),
  ('系統設定', Icons.settings_outlined, '/settings'),
];

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});
  int _index(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final found = _destinations.indexWhere((x) => path.startsWith(x.$3));
    return found < 0 ? 0 : found;
  }

  void _go(BuildContext context, int index) =>
      context.go(_destinations[index].$3);
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final desktop = c.maxWidth >= 800;
      final extended = c.maxWidth >= 1180;
      final selected = _index(context);
      final content = SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          desktop ? 24 : 16,
          desktop ? 18 : 14,
          desktop ? 24 : 16,
          36,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: child,
          ),
        ),
      );
      if (!desktop) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '皮拉提斯課程管理',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            backgroundColor: Colors.white,
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  const _Brand(),
                  Expanded(
                    child: NavigationDrawer(
                      selectedIndex: selected,
                      onDestinationSelected: (i) {
                        Navigator.pop(context);
                        _go(context, i);
                      },
                      children: _destinations
                          .map(
                            (x) => NavigationDrawerDestination(
                              icon: Icon(x.$2),
                              label: Text(x.$1),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: content,
        );
      }
      return Scaffold(
        body: Row(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                navigationRailTheme: NavigationRailThemeData(
                  backgroundColor: brand,
                  indicatorColor: Colors.white,
                  selectedIconTheme: const IconThemeData(color: brand),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.white70,
                  ),
                  selectedLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelTextStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
              child: NavigationRail(
                extended: extended,
                minExtendedWidth: 250,
                selectedIndex: selected,
                onDestinationSelected: (i) => _go(context, i),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: extended
                      ? const SizedBox(width: 210, child: _Brand(dark: true))
                      : const Icon(Icons.auto_awesome, color: Colors.white),
                ),
                destinations: _destinations
                    .map(
                      (x) => NavigationRailDestination(
                        icon: Icon(x.$2),
                        label: Text(x.$1),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(child: content),
          ],
        ),
      );
    },
  );
}

class _Brand extends StatelessWidget {
  final bool dark;
  const _Brand({this.dark = false});
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(Icons.auto_awesome, color: dark ? Colors.white : brand),
    title: Text(
      '皮拉提斯課程管理',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: dark ? Colors.white : null,
      ),
    ),
    subtitle: Text(
      'Coach workspace',
      style: TextStyle(color: dark ? Colors.white60 : null),
    ),
  );
}
