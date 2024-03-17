// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDataModel {
  int? id;
  String? full_name;
  String? mobile_number;
  String? device_id;
  String? first_name;
  String? last_name;
  String? email;
  UserDataModel({
    this.id,
    this.full_name,
    this.mobile_number,
    this.device_id,
    this.first_name,
    this.last_name,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': full_name,
      'mobile_number': mobile_number,
      'device_id': device_id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] != null ? map['id'] as int : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      mobile_number:
          map['mobile_number'] != null ? map['mobile_number'] as String : null,
      device_id: map['device_id'] != null ? map['device_id'] as String : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
