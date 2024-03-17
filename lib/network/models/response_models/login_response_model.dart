// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:room_rental/network/models/request_models/login_request_model.dart';
import 'package:room_rental/network/models/response_models/errors_model.dart';

class LoginResponseData {
  final String? refresh;
  final String? access;
  final String? user_id;
  final String? mobile_number;
  final String? full_name;
  final String? first_name;
  final String? last_name;
  final String? profile_pic;
  final String? email;
  LoginResponseData({
    this.refresh,
    this.access,
    this.user_id,
    this.mobile_number,
    this.full_name,
    this.first_name,
    this.last_name,
    this.profile_pic,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'refresh': refresh,
      'access': access,
      'user_id': user_id,
      'mobile_number': mobile_number,
      'full_name': full_name,
      'first_name': first_name,
      'last_name': last_name,
      'profile_pic': profile_pic,
      'email': email,
    };
  }

  factory LoginResponseData.fromMap(Map<String, dynamic> map) {
    return LoginResponseData(
      refresh: map['refresh'] ?? '',
      access: map['access'] ?? '',
      user_id: map['user_id'] ?? '',
      mobile_number: map['mobile_number'] ?? '',
      full_name: map['full_name'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      profile_pic: map['profile_pic'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseData.fromJson(String source) =>
      LoginResponseData.fromMap(json.decode(source));
}

class LoginResponseModel {
  final LoginRequestModel? request_data;
  final LoginResponseData? response_data;
  final List<ErrorsModel?>? errors;
  final int successCode;
  LoginResponseModel({
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

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      request_data: map['request_data'] != null
          ? LoginRequestModel.fromMap(map['request_data'])
          : null,
      response_data: map['response_data'] != null
          ? LoginResponseData.fromMap(map['response_data'])
          : null,
      errors: map['errors'] != null
          ? List<ErrorsModel?>.from(
              map['errors']?.map((x) => ErrorsModel?.fromMap(x)))
          : null,
      successCode: map['successCode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source));
}
