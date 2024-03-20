// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:room_rental/models/response_models/service_request_model.dart';

class ServiceRequestList {
  final String? month;
  final List<ServiceRequestModel>? objects;
  ServiceRequestList({
    this.month,
    this.objects,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'objects': objects!.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceRequestList.fromMap(Map<String, dynamic> map) {
    return ServiceRequestList(
      month: map['month'] != null ? map['month'] as String : null,
      objects: map['objects'] != null
          ? List<ServiceRequestModel>.from(
              (map['objects'] as List<dynamic>).map<ServiceRequestModel?>(
                (x) => ServiceRequestModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestList.fromJson(String source) =>
      ServiceRequestList.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ServiceRequestListData {
  final List<ServiceRequestList> data;
  ServiceRequestListData({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceRequestListData.fromMap(Map<String, dynamic> map) {
    return ServiceRequestListData(
      data: List<ServiceRequestList>.from(
        (map['data'] as List<dynamic>).map<ServiceRequestList>(
          (x) => ServiceRequestList.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestListData.fromJson(String source) =>
      ServiceRequestListData.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
