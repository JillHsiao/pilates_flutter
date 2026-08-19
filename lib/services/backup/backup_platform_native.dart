import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'backup_platform_types.dart';

Future<Directory> _backupDirectory() async {
  final root = await getApplicationDocumentsDirectory();
  final directory = Directory(p.join(root.path, 'PilatesBackups'));
  await directory.create(recursive: true);
  return directory;
}

Future<void> saveBackup(ExportFileData data) async {
  final directory = await _backupDirectory();
  final file = File(p.join(directory.path, data.name));
  await file.writeAsBytes(data.bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(
      subject: '皮拉提斯資料備份',
      text: '皮拉提斯課程管理離線資料備份',
      files: [XFile(file.path, mimeType: data.mimeType)],
    ),
  );
}

Future<DateTime?> readLastBackupTime() async {
  final directory = await _backupDirectory();
  final files = await directory
      .list()
      .where((entry) => entry is File && entry.path.endsWith('.json'))
      .cast<File>()
      .toList();
  if (files.isEmpty) return null;
  files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
  return files.first.lastModified();
}

Future<PickedBackupData?> pickBackupFile() async {
  final picked = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: const ['json'],
  );
  if (picked == null) return null;
  return PickedBackupData(picked.name, await picked.readAsBytes());
}

Future<void> saveCsvFiles(List<ExportFileData> data) async {
  final temp = await getTemporaryDirectory();
  final directory = Directory(p.join(temp.path, 'pilates_csv_export'));
  await directory.create(recursive: true);
  final files = <XFile>[];
  for (final item in data) {
    final file = File(p.join(directory.path, item.name));
    await file.writeAsBytes(item.bytes, flush: true);
    files.add(XFile(file.path, mimeType: item.mimeType));
  }
  await SharePlus.instance.share(
    ShareParams(subject: '皮拉提斯 CSV 匯出', files: files),
  );
}
