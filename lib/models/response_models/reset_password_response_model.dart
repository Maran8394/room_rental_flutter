// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:room_rental/models/request_models/reset_password_request_model.dart';
import 'package:room_rental/models/response_models/errors_model.dart';

class ResetPasswordResponseData {
  final String message;
  ResetPasswordResponseData({
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ResetPasswordResponseData.fromMap(Map<String, dynamic> map) {
    return ResetPasswordResponseData(
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordResponseData.fromJson(String source) =>
      ResetPasswordResponseData.fromMap(json.decode(source));
}

class ResetPasswordResponseModel {
  final ResetPasswordRequestModel? request_data;
  final ResetPasswordResponseData? response_data;
  final List<ErrorsModel?>? errors;
  final int successCode;
  ResetPasswordResponseModel({
    this.request_data,
    this.response_data,
    this.errors,
    required this.successCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'request_data': request_data?.toMap(),
      'response_data': response_data?.toMap(),
      'errors': errors?.map((x) => x?.toMap()).toList(),
      'successCode': successCode,
    };
  }

  factory ResetPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordResponseModel(
      request_data: map['request_data'] != null
          ? ResetPasswordRequestModel.fromMap(map['request_data'])
          : null,
      response_data: map['response_data'] != null
          ? ResetPasswordResponseData.fromMap(map['response_data'])
          : null,
      errors: map['errors'] != null
          ? List<ErrorsModel?>.from(
              map['errors']?.map((x) => ErrorsModel?.fromMap(x)))
          : null,
      successCode: map['successCode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordResponseModel.fromJson(String source) =>
      ResetPasswordResponseModel.fromMap(json.decode(source));
}
