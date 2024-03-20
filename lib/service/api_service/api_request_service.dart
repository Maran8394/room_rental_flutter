import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class APIRequestService {
  String? authToken;

  Map<String, String> get requestHeader {
    if (authToken != null && authToken!.isNotEmpty) {
      return {
        "Authorization": "Bearer $authToken",
        "Access-Control-Allow-Origin": "*",
        "Accept": "*/*"
      };
    } else {
      return {"Access-Control-Allow-Origin": "*", "Accept": "*/*"};
    }
  }

  void setAuthToken(String token) {
    authToken = token;
  }

  Future<T> _handleRequest<T>(
    String method,
    Uri requestUrl,
    Map<String, dynamic> requestBody,
    T Function(Map<String, dynamic> json) fromMap, {
    List<File>? files,
    String? fileName,
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      http.Response httpResponse;
      switch (method.toUpperCase()) {
        case 'GET':
          httpResponse = await http.get(
            requestUrl,
            headers: requestHeader,
          );
          break;
        case 'POST':
          if (files != null && files.isNotEmpty) {
            // Multipart request with files
            var request = http.MultipartRequest('POST', requestUrl);
            request.headers.addAll(requestHeader);
            for (var file in files) {
              request.files.add(await http.MultipartFile.fromPath(
                fileName!,
                file.path,
              ));
            }
            if (requestBody.isNotEmpty) {
              requestBody.forEach((key, value) {
                request.fields[key] = value.toString();
              });
            }
            var streamedResponse = await request.send();
            httpResponse = await http.Response.fromStream(streamedResponse);
          } else {
            // Regular POST request
            httpResponse = await http.post(
              requestUrl,
              body: requestBody,
              headers: requestHeader,
            );
          }
          break;

        case 'PUT':
          if (files != null && files.isNotEmpty) {
            // Multipart request with files
            var request = http.MultipartRequest('PUT', requestUrl);
            request.headers.addAll(requestHeader);
            for (var file in files) {
              request.files.add(await http.MultipartFile.fromPath(
                fileName!,
                file.path,
              ));
            }
            if (requestBody.isNotEmpty) {
              requestBody.forEach((key, value) {
                request.fields[key] = value.toString();
              });
            }
            var streamedResponse = await request.send();
            httpResponse = await http.Response.fromStream(streamedResponse);
          } else {
            // Regular PUT request
            httpResponse = await http.put(
              requestUrl,
              body: requestBody,
              headers: requestHeader,
            );
          }
          break;

        default:
          throw Exception('Unsupported HTTP method: $method');
      }
      final responseBody = json.decode(httpResponse.body);

      return fromMap(responseBody);
    } else {
      throw Exception('No internet connection available.');
    }
  }

  Future<T> getRequest<T>(
      Uri requestUrl, T Function(Map<String, dynamic> json) fromMap) async {
    return _handleRequest(
      'GET',
      requestUrl,
      {},
      fromMap,
    );
  }

  Future<T> postRequest<T>(Uri requestUrl, Map<String, dynamic> requestBody,
      T Function(Map<String, dynamic> json) fromMap,
      {List<File>? files, String? fileName}) async {
    return _handleRequest(
      'POST',
      requestUrl,
      requestBody,
      fromMap,
      files: files,
      fileName: fileName,
    );
  }

  Future<T> putRequest<T>(Uri requestUrl, Map<String, dynamic> requestBody,
      T Function(Map<String, dynamic> json) fromMap,
      {List<File>? files, String? fileName}) async {
    return _handleRequest(
      'PUT',
      requestUrl,
      requestBody,
      fromMap,
      files: files,
      fileName: fileName,
    );
  }
}
