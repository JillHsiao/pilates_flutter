import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor openDatabaseConnection() => LazyDatabase(() async {
  final result = await WasmDatabase.open(
    databaseName: 'pilates',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );

  if (result.chosenImplementation == WasmStorageImplementation.inMemory) {
    throw StateError('此瀏覽器無法提供持久化資料庫。請使用最新版 Safari、Chrome 或 Edge，且不要使用私人瀏覽模式。');
  }
  return result.resolvedExecutor;
});
