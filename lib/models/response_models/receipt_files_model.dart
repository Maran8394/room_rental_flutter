import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReceiptFilesModel {
  final String? file;
  ReceiptFilesModel({
    this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
    };
  }

  factory ReceiptFilesModel.fromMap(Map<String, dynamic> map) {
    return ReceiptFilesModel(
      file: map['file'] != null ? map['file'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiptFilesModel.fromJson(String source) =>
      ReceiptFilesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
