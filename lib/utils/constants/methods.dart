// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

String base64Decoder(String data) {
  try {
    List<int> decodedBytes = base64.decode(data);
    String decodedString = utf8.decode(decodedBytes);
    return decodedString;
  } catch (e) {
    return e.toString();
  }
}

String base64Encoder(String data) {
  List<int> encodedBytes = utf8.encode(data);
  String encodedString = base64.encode(encodedBytes);
  return encodedString;
}

bool isTokenExpired(String? token) {
  if (token != null) {
    bool hasExpired = JwtDecoder.isExpired(token);
    return hasExpired;
  } else {
    return true;
  }
}

String getFileName(String filePath) {
  List<String> pathParts = filePath.split('/');
  String fileName = pathParts.last;
  return fileName;
}

String getCurrentMonth() {
  DateTime now = DateTime.now();
  String monthAbbreviation = DateFormat('MMM').format(now);
  return monthAbbreviation;
}
