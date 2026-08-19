import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:pilates_flutter/core/database/app_database.dart';
import 'package:pilates_flutter/repositories/student_repository.dart';
import 'package:web/web.dart' as web;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const marker = 'WEB-PERSISTENCE-蕭宇筑';

  debugPrint('WEB_PERSISTENCE_STAGE opening');
  var database = AppDatabase();
  final studentId = await StudentRepository(database)
      .create({'name': marker, 'joinDate': '2026-08-19'})
      .timeout(const Duration(seconds: 30));
  debugPrint('WEB_PERSISTENCE_STAGE created');
  await database.close();

  debugPrint('WEB_PERSISTENCE_STAGE reopening');
  database = AppDatabase();
  final restored = await StudentRepository(
    database,
  ).get(studentId).timeout(const Duration(seconds: 30));
  if (restored.name != marker) {
    throw StateError('IndexedDB persistence verification failed');
  }
  debugPrint('WEB_PERSISTENCE_PASS id=$studentId name=${restored.name}');
  await database.customStatement('DELETE FROM students WHERE id = ?', [
    studentId,
  ]);
  await database.close();

  await web.window.navigator.serviceWorker.ready.toDart.timeout(
    const Duration(seconds: 30),
  );
  for (final path in const [
    './index.html',
    './main.dart.js',
    './sqlite3.wasm',
    './drift_worker.js',
    './canvaskit/canvaskit.wasm',
  ]) {
    final cached = await web.window.caches.match(path.toJS).toDart;
    if (cached == null) throw StateError('Offline cache missing $path');
  }
  debugPrint('OFFLINE_CACHE_PASS');

  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Text('WEB_PERSISTENCE_PASS'))),
    ),
  );
}
