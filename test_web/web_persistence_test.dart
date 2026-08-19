import 'package:drift/wasm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_flutter/core/database/app_database.dart';
import 'package:pilates_flutter/repositories/student_repository.dart';
import 'package:sqlite3/wasm.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'SQLite WASM persists student after closing and reopening IndexedDB',
    () async {
      const indexedDbName = 'pilates_web_persistence_test';
      await IndexedDbFileSystem.deleteDatabase(indexedDbName);
      final asset = await rootBundle.load('web/sqlite3.wasm');
      final wasmBytes = Uint8List.sublistView(asset);

      final sqlite = await WasmSqlite3.load(wasmBytes);
      final fileSystem = await IndexedDbFileSystem.open(dbName: indexedDbName);
      sqlite.registerVirtualFileSystem(fileSystem, makeDefault: true);
      var database = AppDatabase.forTesting(
        WasmDatabase(
          sqlite3: sqlite,
          path: 'pilates.db',
          fileSystem: fileSystem,
        ),
      );
      final studentId = await StudentRepository(
        database,
      ).create({'name': '蕭宇筑', 'joinDate': '2026-08-19'});
      await fileSystem.flush();
      await database.close();
      await fileSystem.close();

      final reopenedSqlite = await WasmSqlite3.load(wasmBytes);
      final reopenedFileSystem = await IndexedDbFileSystem.open(
        dbName: indexedDbName,
      );
      reopenedSqlite.registerVirtualFileSystem(
        reopenedFileSystem,
        makeDefault: true,
      );
      database = AppDatabase.forTesting(
        WasmDatabase(
          sqlite3: reopenedSqlite,
          path: 'pilates.db',
          fileSystem: reopenedFileSystem,
        ),
      );

      final restored = await StudentRepository(database).get(studentId);
      expect(restored.name, '蕭宇筑');
      expect(restored.id, studentId);
      await database.close();
      await reopenedFileSystem.close();
      await IndexedDbFileSystem.deleteDatabase(indexedDbName);
    },
  );
}
