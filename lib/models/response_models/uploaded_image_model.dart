import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UploadedFiles {
  final int? id;
  final String type;
  final String file;
  UploadedFiles({
    this.id,
    required this.type,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'file': file,
    };
  }

  factory UploadedFiles.fromMap(Map<String, dynamic> map) {
    return UploadedFiles(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] as String,
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadedFiles.fromJson(String source) =>
      UploadedFiles.fromMap(json.decode(source) as Map<String, dynamic>);
}
