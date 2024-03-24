// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:room_rental/models/response_models/bill_model.dart';

class BillStatus {
  double? total_amount;
  double? total_tax;
  bool? admin_verified_status;
  bool? paid_status;
  List<BillModel>? objs;
  List<int?>? generated_bil_rental_record_id;
  List<int?>? not_gen_properties;

  BillStatus({
    this.total_amount,
    this.total_tax,
    this.admin_verified_status,
    this.paid_status,
    this.objs,
    this.generated_bil_rental_record_id,
    this.not_gen_properties,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_amount': total_amount,
      'total_tax': total_tax,
      'admin_verified_status': admin_verified_status,
      'paid_status': paid_status,
      'obj_ids': objs!.map((x) => x.toMap()).toList(),
      'generated_bil_rental_record_id':
          generated_bil_rental_record_id!.map((x) => x).toList(),
      'not_gen_properties': not_gen_properties!.map((x) => x).toList(),
    };
  }

  factory BillStatus.fromMap(Map<String, dynamic> map) {
    return BillStatus(
      total_amount:
          map['total_amount'] != null ? map['total_amount'] as double : null,
      total_tax: map['total_tax'] != null ? map['total_tax'] as double : null,
      admin_verified_status: map['admin_verified_status'] != null
          ? map['admin_verified_status'] as bool
          : null,
      paid_status:
          map['paid_status'] != null ? map['paid_status'] as bool : null,
      objs: map['objs'] != null
          ? List<BillModel>.from(
              (map['objs'] as List<dynamic>).map<BillModel?>(
                (x) => BillModel?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      generated_bil_rental_record_id:
          map['generated_bil_rental_record_id'] != null
              ? (map['generated_bil_rental_record_id'] as List<dynamic>)
                  .map<int?>((x) {
                  if (x is int) {
                    return x;
                  } else if (x is String) {
                    return int.tryParse(x);
                  } else {
                    return null;
                  }
                }).toList()
              : null,
      not_gen_properties: map['not_gen_properties'] != null
          ? (map['not_gen_properties'] as List<dynamic>).map<int?>((x) {
              if (x is int) {
                return x;
              } else if (x is String) {
                return int.tryParse(x);
              } else {
                return null;
              }
            }).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillStatus.fromJson(String source) =>
      BillStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PaymentPageModel {
  BillStatus? rent;
  BillStatus? electricity;
  BillStatus? water;
  BillStatus? service;
  List<int?>? properties_ids;

  PaymentPageModel({
    this.rent,
    this.electricity,
    this.water,
    this.service,
    this.properties_ids,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rent': rent?.toMap(),
      'electricity': electricity?.toMap(),
      'water': water?.toMap(),
      'service': service?.toMap(),
      'properties_ids': properties_ids,
    };
  }

  factory PaymentPageModel.fromMap(Map<String, dynamic> map) {
    return PaymentPageModel(
      rent: map['rent'] != null
          ? BillStatus.fromMap(map['rent'] as Map<String, dynamic>)
          : null,
      electricity: map['electricity'] != null
          ? BillStatus.fromMap(map['electricity'] as Map<String, dynamic>)
          : null,
      water: map['water'] != null
          ? BillStatus.fromMap(map['water'] as Map<String, dynamic>)
          : null,
      service: map['service'] != null
          ? BillStatus.fromMap(map['service'] as Map<String, dynamic>)
          : null,
      properties_ids: map['properties_ids'] != null
          ? (map['properties_ids'] as List<dynamic>).map<int?>((x) {
              if (x is int) {
                return x;
              } else if (x is String) {
                return int.tryParse(x);
              } else {
                return null;
              }
            }).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentPageModel.fromJson(String source) =>
      PaymentPageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
