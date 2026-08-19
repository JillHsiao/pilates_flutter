import 'dart:typed_data';

class ExportFileData {
  final String name;
  final String mimeType;
  final Uint8List bytes;

  const ExportFileData(this.name, this.mimeType, this.bytes);
}

class PickedBackupData {
  final String name;
  final Uint8List bytes;

  const PickedBackupData(this.name, this.bytes);
}
