import 'dart:convert';

class DownloadFileRequest {
  DownloadFileRequest({
    required this.filePath,
    required this.fileName,
    required this.storage,
  });

  String filePath;
  String fileName;
  String storage;

  Map<String, dynamic> toMap() => {
        "filePath": filePath,
        "fileName": fileName,
        "storage": storage,
      };

  String toJson() => json.encode(toMap());
}
