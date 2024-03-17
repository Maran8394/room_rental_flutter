// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:room_rental/models/response_models/property_model.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';

class TenantRentalRecord {
  int? id;
  dynamic paid_deposit_amount;
  bool? own_whole_property;
  String? tenancy_agreement;
  dynamic agreement_period;
  dynamic monthly_rent;
  String? checkin_date;
  String? checkout_date;
  String? created_on;
  String? updated_on;
  PropertyModel? property;
  List<TenantRoomDataModel>? room;
  TenantRentalRecord({
    this.id,
    this.paid_deposit_amount,
    this.own_whole_property,
    this.tenancy_agreement,
    required this.agreement_period,
    required this.monthly_rent,
    this.checkin_date,
    this.checkout_date,
    this.created_on,
    this.updated_on,
    this.property,
    this.room,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paid_deposit_amount': paid_deposit_amount,
      'own_whole_property': own_whole_property,
      'tenancy_agreement': tenancy_agreement,
      'agreement_period': agreement_period,
      'monthly_rent': monthly_rent,
      'checkin_date': checkin_date,
      'checkout_date': checkout_date,
      'created_on': created_on,
      'updated_on': updated_on,
      'property': property?.toMap(),
      'room': room!.map((x) => x.toMap()).toList(),
    };
  }

  factory TenantRentalRecord.fromMap(Map<String, dynamic> map) {
    return TenantRentalRecord(
      id: map['id'] != null ? map['id'] as int : null,
      paid_deposit_amount: map['paid_deposit_amount'] != null
          ? map['paid_deposit_amount'] as dynamic
          : null,
      own_whole_property: map['own_whole_property'] != null
          ? map['own_whole_property'] as bool
          : null,
      tenancy_agreement: map['tenancy_agreement'] != null
          ? map['tenancy_agreement'] as String
          : null,
      agreement_period: map['agreement_period'] as dynamic,
      monthly_rent: map['monthly_rent'] as dynamic,
      checkin_date:
          map['checkin_date'] != null ? map['checkin_date'] as String : null,
      checkout_date:
          map['checkout_date'] != null ? map['checkout_date'] as String : null,
      created_on:
          map['created_on'] != null ? map['created_on'] as String : null,
      updated_on:
          map['updated_on'] != null ? map['updated_on'] as String : null,
      property: map['property'] != null
          ? PropertyModel.fromMap(map['property'] as Map<String, dynamic>)
          : null,
      room: map['room'] != null
          ? List<TenantRoomDataModel>.from(
              (map['room'] as List<dynamic>).map<TenantRoomDataModel?>(
                (x) => TenantRoomDataModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TenantRentalRecord.fromJson(String source) =>
      TenantRentalRecord.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TenantRentalRecordList {
  final List<TenantRentalRecord>? response_data;
  TenantRentalRecordList({
    this.response_data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'response_data': response_data!.map((x) => x.toMap()).toList(),
    };
  }

  factory TenantRentalRecordList.fromMap(Map<String, dynamic> map) {
    return TenantRentalRecordList(
      response_data: map['response_data'] != null
          ? List<TenantRentalRecord>.from(
              (map['response_data'] as List<dynamic>).map<TenantRentalRecord?>(
                (x) => TenantRentalRecord.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TenantRentalRecordList.fromJson(String source) =>
      TenantRentalRecordList.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
