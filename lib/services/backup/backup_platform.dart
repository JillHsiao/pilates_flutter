import 'backup_platform_native.dart'
    if (dart.library.js_interop) 'backup_platform_web.dart'
    as platform;
import 'backup_platform_types.dart';

Future<void> saveBackup(ExportFileData file) => platform.saveBackup(file);
Future<DateTime?> readLastBackupTime() => platform.readLastBackupTime();
Future<PickedBackupData?> pickBackupFile() => platform.pickBackupFile();
Future<void> saveCsvFiles(List<ExportFileData> files) =>
    platform.saveCsvFiles(files);
