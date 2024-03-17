// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:room_rental/network/models/response_models/errors_model.dart';

class ChangePasswordDataModel {
  String? old_password;
  String? new_password;
  String? confirm_password;
  bool? status;
  bool? has_errors;
  ChangePasswordDataModel({
    this.old_password,
    this.new_password,
    this.confirm_password,
    this.status,
    this.has_errors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'old_password': old_password,
      'new_password': new_password,
      'confirm_password': confirm_password,
      'status': status,
      'has_errors': has_errors,
    };
  }

  factory ChangePasswordDataModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordDataModel(
      old_password:
          map['old_password'] != null ? map['old_password'] as String : null,
      new_password:
          map['new_password'] != null ? map['new_password'] as String : null,
      confirm_password: map['confirm_password'] != null
          ? map['confirm_password'] as String
          : null,
      status: map['status'] != null ? map['status'] as bool : null,
      has_errors: map['has_errors'] != null ? map['has_errors'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordDataModel.fromJson(String source) =>
      ChangePasswordDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ChangePasswordResponseModel {
  final ChangePasswordDataModel? data;
  final String? error;
  final List<ErrorsModel?>? errors;
  ChangePasswordResponseModel({
    this.data,
    this.error,
    this.errors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'error': error,
      'errors': errors!.map((x) => x?.toMap()).toList(),
    };
  }

  factory ChangePasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponseModel(
      data: map['data'] != null
          ? ChangePasswordDataModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      error: map['error'] != null ? map['error'] as String : null,
      errors: map['errors'] != null
          ? List<ErrorsModel?>.from(
              (map['errors'] as List<dynamic>).map<ErrorsModel?>(
                (x) => ErrorsModel?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordResponseModel.fromJson(String source) =>
      ChangePasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
