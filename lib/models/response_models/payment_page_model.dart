// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class BillStatus {
  double? total_amount;
  bool? admin_verified_status;
  List<int?>? obj_ids;
  BillStatus({
    this.total_amount,
    this.admin_verified_status,
    this.obj_ids,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_amount': total_amount,
      'admin_verified_status': admin_verified_status,
      'obj_ids': obj_ids!.map((x) => x).toList(),
    };
  }

  factory BillStatus.fromMap(Map<String, dynamic> map) {
    return BillStatus(
      total_amount:
          map['total_amount'] != null ? map['total_amount'] as double : null,
      admin_verified_status: map['admin_verified_status'] != null
          ? map['admin_verified_status'] as bool
          : null,
      obj_ids: map['obj_ids'] != null
          ? List<int?>.from(
              (map['obj_ids'] as List<dynamic>).map<int?>(
                (x) => int.parse(x.toString()),
              ),
            )
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

  PaymentPageModel({
    this.rent,
    this.electricity,
    this.water,
    this.service,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rent': rent?.toMap(),
      'electricity': electricity?.toMap(),
      'water': water?.toMap(),
      'service': service?.toMap(),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentPageModel.fromJson(String source) =>
      PaymentPageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
