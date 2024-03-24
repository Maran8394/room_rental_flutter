// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/models/response_models/uploaded_image_model.dart';

class BillModel {
  int? id;
  String? bill_type;
  String? bill_number;
  String? units;
  String? price_per_unit;
  String? for_month;
  String? remarks;
  String? bill_status;
  String? bill_approval_status;
  String? amount;
  String? tax;
  bool? does_admin_verified;
  dynamic admin_verified_at;
  dynamic created_on;
  dynamic updated_on;
  TenantRentalRecord? tenant_rental_record;
  List<UploadedFiles>? uploaded_reference_doc;
  List<UploadedFiles>? upload_bill;
  BillModel({
    this.id,
    this.bill_type,
    this.bill_number,
    this.units,
    this.price_per_unit,
    this.for_month,
    this.remarks,
    this.bill_status,
    this.bill_approval_status,
    this.amount,
    this.tax,
    this.does_admin_verified,
    required this.admin_verified_at,
    required this.created_on,
    required this.updated_on,
    this.tenant_rental_record,
    this.uploaded_reference_doc,
    this.upload_bill,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bill_type': bill_type,
      'bill_number': bill_number,
      'units': units,
      'price_per_unit': price_per_unit,
      'for_month': for_month,
      'remarks': remarks,
      'bill_status': bill_status,
      'bill_approval_status': bill_approval_status,
      'amount': amount,
      'tax': tax,
      'does_admin_verified': does_admin_verified,
      'admin_verified_at': admin_verified_at,
      'created_on': created_on,
      'updated_on': updated_on,
      'tenant_rental_record': tenant_rental_record?.toMap(),
      'uploaded_reference_doc':
          uploaded_reference_doc!.map((x) => x.toMap()).toList(),
      'upload_bill': upload_bill!.map((x) => x.toMap()).toList(),
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map['id'] != null ? map['id'] as int : null,
      bill_type: map['bill_type'] != null ? map['bill_type'] as String : null,
      bill_number:
          map['bill_number'] != null ? map['bill_number'] as String : null,
      units: map['units'] != null ? map['units'] as String : null,
      price_per_unit: map['price_per_unit'] != null
          ? map['price_per_unit'] as String
          : null,
      for_month: map['for_month'] != null ? map['for_month'] as String : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      bill_status:
          map['bill_status'] != null ? map['bill_status'] as String : null,
      bill_approval_status: map['bill_approval_status'] != null
          ? map['bill_approval_status'] as String
          : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      tax: map['tax'] != null ? map['tax'] as String : null,
      does_admin_verified: map['does_admin_verified'] != null
          ? map['does_admin_verified'] as bool
          : null,
      admin_verified_at: map['admin_verified_at'] as dynamic,
      created_on: map['created_on'] as dynamic,
      updated_on: map['updated_on'] as dynamic,
      tenant_rental_record: map['tenant_rental_record'] != null
          ? TenantRentalRecord.fromMap(
              map['tenant_rental_record'] as Map<String, dynamic>)
          : null,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) =>
      BillModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
