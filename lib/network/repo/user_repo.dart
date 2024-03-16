import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:room_rental/models/response_models/create_bill_response_data.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/network/models/response_models/forgot_password_response_model.dart';
import 'package:room_rental/network/models/response_models/reset_password_response_model.dart';
import 'package:room_rental/service/api_service/api_request_service.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/network/models/response_models/login_response_model.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';

class UserRepo {
  final APIRequestService _apiRequestService = APIRequestService();

  void setAuthToken() async {
    var token = await Storage.getValue(StorageKeys.accessToken);
    _apiRequestService.setAuthToken(token!);
  }

  Future<LoginResponseModel> login(Map<String, dynamic> requestBody) async {
    Uri requestUrl = Uri.parse(ApiUrls.signin);
    try {
      var loginResponse =
          await _apiRequestService.postRequest<LoginResponseModel>(
        requestUrl,
        requestBody,
        (json) => LoginResponseModel.fromMap(json),
      );
      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResponseModel> forgotPassword(
      Map<String, dynamic> requestBody) async {
    Uri requestUrl = Uri.parse(ApiUrls.forgotPassword);
    final httpResponse = await http.post(
      requestUrl,
      body: requestBody,
      headers: _apiRequestService.requestHeader,
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
      headers: _apiRequestService.requestHeader,
    );
    final responseBody = json.decode(httpResponse.body);
    ResetPasswordResponseModel toModel =
        ResetPasswordResponseModel.fromMap(responseBody);
    return toModel;
  }

  Future<TenantRentalRecordList>? getProperties() async {
    Uri requestUrl = Uri.parse(ApiUrls.getProperties);
    setAuthToken();
    try {
      var response =
          await _apiRequestService.getRequest<TenantRentalRecordList>(
        requestUrl,
        (json) => TenantRentalRecordList.fromMap(json),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateBillResponseData> createBill(
      {required Map<String, dynamic> requestBody,
      required String imageUrl}) async {
    Uri requestUrl = Uri.parse(ApiUrls.createBill);
    setAuthToken();

    // try {
    var imageFile = File(imageUrl);
    var response = await _apiRequestService.postRequest(
      requestUrl,
      requestBody,
      (json) => CreateBillResponseData.fromMap(json["response_data"]),
      files: [imageFile],
      fileName: "uploaded_image",
    );
    return response;
    // } catch (e) {
    //   rethrow;
    // }
  }
}
