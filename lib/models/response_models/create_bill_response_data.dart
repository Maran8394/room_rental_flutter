// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:room_rental/models/response_models/service_request_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateBillResponseData {
  int? id;
  String? bill_type;
  String? bill_number;
  String? units;
  String? price_per_unit;
  String? for_month;
  String? uploaded_image;
  String? upload_bill;
  String? remarks;
  String? bill_status;
  double? amount;
  bool? does_admin_verified;
  String? admin_verified_at;
  String? created_on;
  String? updated_on;
  int? tenant;
  int? tenant_rental_record;
  List<ServiceRequestModel>? service_requests;

  CreateBillResponseData({
    this.id,
    this.bill_type,
    this.bill_number,
    this.units,
    this.price_per_unit,
    this.for_month,
    this.uploaded_image,
    this.upload_bill,
    this.remarks,
    this.bill_status,
    this.amount,
    this.does_admin_verified,
    this.admin_verified_at,
    this.created_on,
    this.updated_on,
    this.tenant,
    this.tenant_rental_record,
    this.service_requests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bill_type': bill_type,
      'bill_number': bill_number,
      'units': units,
      'price_per_unit': price_per_unit,
      'for_month': for_month,
      'uploaded_image': uploaded_image,
      'upload_bill': upload_bill,
      'remarks': remarks,
      'bill_status': bill_status,
      'amount': amount,
      'does_admin_verified': does_admin_verified,
      'admin_verified_at': admin_verified_at,
      'created_on': created_on,
      'updated_on': updated_on,
      'tenant': tenant,
      'tenant_rental_record': tenant_rental_record,
      'service_requests': service_requests!.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateBillResponseData.fromMap(Map<String, dynamic> map) {
    return CreateBillResponseData(
      id: map['id'] != null ? map['id'] as int : null,
      bill_type: map['bill_type'] != null ? map['bill_type'] as String : null,
      bill_number:
          map['bill_number'] != null ? map['bill_number'] as String : null,
      units: map['units'] != null ? map['units'] as String : null,
      price_per_unit: map['price_per_unit'] != null
          ? map['price_per_unit'] as String
          : null,
      for_month: map['for_month'] != null ? map['for_month'] as String : null,
      uploaded_image: map['uploaded_image'] != null
          ? map['uploaded_image'] as String
          : null,
      upload_bill:
          map['upload_bill'] != null ? map['upload_bill'] as String : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      bill_status:
          map['bill_status'] != null ? map['bill_status'] as String : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
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
      tenant: map['tenant'] != null ? map['tenant'] as int : null,
      tenant_rental_record: map['tenant_rental_record'] != null
          ? map['tenant_rental_record'] as int
          : null,
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
