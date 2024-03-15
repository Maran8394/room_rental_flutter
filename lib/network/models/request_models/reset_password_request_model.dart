// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ResetPasswordRequestModel {
  final String? user_name;
  final String? password;
  ResetPasswordRequestModel({
    this.user_name,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'password': password,
    };
  }

  factory ResetPasswordRequestModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordRequestModel(
      user_name: map['user_name'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordRequestModel.fromJson(String source) =>
      ResetPasswordRequestModel.fromMap(json.decode(source));
}
