import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/lessons/lessons_page.dart';
import '../features/purchases/purchases_page.dart';
import '../features/reports/reports_page.dart';
import '../features/settings/settings_page.dart';
import '../features/students/student_detail_page.dart';
import '../features/students/students_page.dart';
import '../widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (_, _) => const DashboardPage()),
        GoRoute(path: '/students', builder: (_, _) => const StudentsPage()),
        GoRoute(
          path: '/students/:id',
          builder: (_, state) =>
              StudentDetailPage(id: int.parse(state.pathParameters['id']!)),
        ),
        GoRoute(path: '/lessons', builder: (_, _) => const LessonsPage()),
        GoRoute(path: '/purchases', builder: (_, _) => const PurchasesPage()),
        GoRoute(path: '/reports', builder: (_, _) => const ReportsPage()),
        GoRoute(path: '/settings', builder: (_, _) => const SettingsPage()),
      ],
    ),
  ],
  errorBuilder: (_, _) => const Scaffold(body: Center(child: Text('找不到頁面'))),
);
