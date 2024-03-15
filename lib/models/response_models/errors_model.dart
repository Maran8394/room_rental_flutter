import 'dart:convert';

class ErrorsModel {
  final String? fieldId;
  final String? message;
  ErrorsModel({
    this.fieldId,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'fieldId': fieldId,
      'message': message,
    };
  }

  factory ErrorsModel.fromMap(Map<String, dynamic> map) {
    return ErrorsModel(
      fieldId: map['fieldId'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorsModel.fromJson(String source) => ErrorsModel.fromMap(json.decode(source));
}
