// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:room_rental/models/response_models/service_request_model.dart';
import 'package:room_rental/models/response_models/uploaded_image_model.dart';

class CreateBillResponseData {
  int? id;
  String? bill_type;
  String? bill_number;
  double? price_per_unit;
  String? for_month;
  List<UploadedFiles>? uploaded_reference_doc;
  List<UploadedFiles>? upload_bill;
  String? remarks;
  String? bill_status;
  double? amount;
  double? tax;
  bool? does_admin_verified;
  String? admin_verified_at;
  String? created_on;
  String? updated_on;
  List<ServiceRequestModel>? service_requests;
  CreateBillResponseData({
    this.id,
    this.bill_type,
    this.bill_number,
    this.price_per_unit,
    this.for_month,
    this.uploaded_reference_doc,
    this.upload_bill,
    this.remarks,
    this.bill_status,
    this.amount,
    this.tax,
    this.does_admin_verified,
    this.admin_verified_at,
    this.created_on,
    this.updated_on,
    this.service_requests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bill_type': bill_type,
      'bill_number': bill_number,
      'price_per_unit': price_per_unit,
      'for_month': for_month,
      'uploaded_reference_doc':
          uploaded_reference_doc!.map((x) => x.toMap()).toList(),
      'upload_bill': upload_bill!.map((x) => x.toMap()).toList(),
      'remarks': remarks,
      'bill_status': bill_status,
      'amount': amount,
      'tax': tax,
      'does_admin_verified': does_admin_verified,
      'admin_verified_at': admin_verified_at,
      'created_on': created_on,
      'updated_on': updated_on,
      'service_requests': service_requests!.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateBillResponseData.fromMap(Map<String, dynamic> map) {
    return CreateBillResponseData(
      id: map['id'] != null ? map['id'] as int : null,
      bill_type: map['bill_type'] != null ? map['bill_type'] as String : null,
      bill_number:
          map['bill_number'] != null ? map['bill_number'] as String : null,
      price_per_unit: map['price_per_unit'] != null
          ? map['price_per_unit'] as double
          : null,
      for_month: map['for_month'] != null ? map['for_month'] as String : null,
      uploaded_reference_doc: map['uploaded_reference_doc'] != null
          ? List<UploadedFiles>.from(
              (map['uploaded_reference_doc'] as List<dynamic>)
                  .map<UploadedFiles?>(
                (x) => UploadedFiles.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      upload_bill: map['upload_bill'] != null
          ? List<UploadedFiles>.from(
              (map['upload_bill'] as List<dynamic>).map<UploadedFiles?>(
                (x) => UploadedFiles.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      bill_status:
          map['bill_status'] != null ? map['bill_status'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      tax: map['tax'] != null ? map['tax'] as double : null,
      does_admin_verified: map['does_admin_verified'] != null
          ? map['does_admin_verified'] as bool
          : null,
      admin_verified_at: map['admin_verified_at'] != null
          ? map['admin_verified_at'] as String
          : null,
      created_on:
          map['created_on'] != null ? map['created_on'] as String : null,
      updated_on:
          map['updated_on'] != null ? map['updated_on'] as String : null,
      service_requests: map['service_requests'] != null
          ? List<ServiceRequestModel>.from(
              (map['service_requests'] as List<dynamic>)
                  .map<ServiceRequestModel?>(
                (x) => ServiceRequestModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBillResponseData.fromJson(String source) =>
      CreateBillResponseData.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
