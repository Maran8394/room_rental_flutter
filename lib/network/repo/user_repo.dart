import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:room_rental/network/models/response_models/forgot_password_response_model.dart';
import 'package:room_rental/network/models/response_models/reset_password_response_model.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/network/models/response_models/login_response_model.dart';

class UserRepo {
  Map<String, String> get requestHeader =>
      {"Access-Control-Allow-Origin": "*", 'Accept': '*/*'};

  Future<LoginResponseModel> login(Map<String, dynamic> requestBody) async {
    Uri requestUrl = Uri.parse(ApiUrls.signin);
    
    final httpResponse = await http.post(
      requestUrl,
      body: requestBody,
      headers: requestHeader,
    );
    final responseBody = json.decode(httpResponse.body);
    LoginResponseModel toModel = LoginResponseModel.fromMap(responseBody);
    return toModel;
  }

  Future<ForgotPasswordResponseModel> forgotPassword(
      Map<String, dynamic> requestBody) async {
    Uri requestUrl = Uri.parse(ApiUrls.forgotPassword);
    final httpResponse = await http.post(
      requestUrl,
      body: requestBody,
      headers: requestHeader,
    );
    final responseBody = json.decode(httpResponse.body);
    ForgotPasswordResponseModel toModel =
        ForgotPasswordResponseModel.fromMap(responseBody);
    return toModel;
  }

  Future<ResetPasswordResponseModel> resetPassword(
      Map<String, dynamic> requestBody) async {
    Uri requestUrl = Uri.parse(ApiUrls.resetPassword);
    final httpResponse = await http.post(
      requestUrl,
      body: requestBody,
      headers: requestHeader,
    );
    final responseBody = json.decode(httpResponse.body);
    ResetPasswordResponseModel toModel =
        ResetPasswordResponseModel.fromMap(responseBody);
    return toModel;
  }
}
