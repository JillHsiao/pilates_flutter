import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

class PilatesApp extends StatelessWidget {
  const PilatesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: '皮拉提斯課程管理',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    routerConfig: appRouter,
  );
}
