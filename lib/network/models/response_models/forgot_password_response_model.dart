// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:room_rental/network/models/request_models/forgot_password_request_model.dart';
import 'package:room_rental/network/models/response_models/errors_model.dart';

class ForgotPasswordResponseData {
  final String? otp;
  ForgotPasswordResponseData({
    this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
    };
  }

  factory ForgotPasswordResponseData.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponseData(
      otp: map['otp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordResponseData.fromJson(String source) =>
      ForgotPasswordResponseData.fromMap(json.decode(source));
}

class ForgotPasswordResponseModel {
  final ForgotPasswordRequestModel? request_data;
  final ForgotPasswordResponseData? response_data;
  final List<ErrorsModel?>? errors;
  final int successCode;
  ForgotPasswordResponseModel({
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

  factory ForgotPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponseModel(
      request_data: map['request_data'] != null
          ? ForgotPasswordRequestModel.fromMap(map['request_data'])
          : null,
      response_data: map['response_data'] != null
          ? ForgotPasswordResponseData.fromMap(map['response_data'])
          : null,
      errors: map['errors'] != null
          ? List<ErrorsModel?>.from(
              map['errors']?.map((x) => ErrorsModel?.fromMap(x)))
          : null,
      successCode: map['successCode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordResponseModel.fromJson(String source) =>
      ForgotPasswordResponseModel.fromMap(json.decode(source));
}
