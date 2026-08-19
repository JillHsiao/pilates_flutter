import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:web/web.dart' as web;

import 'backup_platform_types.dart';

const _lastBackupKey = 'pilates.lastBackupAt';

void _download(ExportFileData data) {
  final blob = web.Blob(
    [data.bytes.toJS].toJS,
    web.BlobPropertyBag(type: data.mimeType),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = data.name;
  anchor.click();
  web.URL.revokeObjectURL(url);
}

Future<void> saveBackup(ExportFileData data) async {
  _download(data);
  web.window.localStorage.setItem(
    _lastBackupKey,
    DateTime.now().toIso8601String(),
  );
}

Future<DateTime?> readLastBackupTime() async {
  final value = web.window.localStorage.getItem(_lastBackupKey);
  return value == null ? null : DateTime.tryParse(value);
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
  for (final file in data) {
    _download(file);
  }
}
