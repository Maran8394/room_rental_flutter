// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ForgotPasswordRequestModel {
  final String? userName;
  ForgotPasswordRequestModel({
    this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': userName,
    };
  }

  factory ForgotPasswordRequestModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordRequestModel(
      userName: map['user_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordRequestModel.fromJson(String source) =>
      ForgotPasswordRequestModel.fromMap(json.decode(source));
}
