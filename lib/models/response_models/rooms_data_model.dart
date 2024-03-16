// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class TenantRoomDataModel {
  int? id;
  String? room_name;
  String? room_type;
  String? monthly_rent;
  String? description;
  bool? is_available;
  Map? facilities;
  String? created_at;
  String? updated_at;
  TenantRoomDataModel({
    this.id,
    this.room_name,
    this.room_type,
    this.monthly_rent,
    this.description,
    this.is_available,
    this.facilities,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room_name': room_name,
      'room_type': room_type,
      'monthly_rent': monthly_rent,
      'description': description,
      'is_available': is_available,
      'facilities':
          facilities != null ? Map<String, dynamic>.from(facilities!) : null,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory TenantRoomDataModel.fromMap(Map<String, dynamic> map) {
    return TenantRoomDataModel(
      id: map['id'] as int,
      room_name: map['room_name'] != null ? map['room_name'] as String : null,
      room_type: map['room_type'] != null ? map['room_type'] as String : null,
      monthly_rent:
          map['monthly_rent'] != null ? map['monthly_rent'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      is_available:
          map['is_available'] != null ? map['is_available'] as bool : null,
      facilities: map['facilities'] != null
          ? Map.from(map['facilities'] as Map<String, dynamic>)
          : null,
      created_at:
          map['created_at'] != null ? map['created_at'] as String : null,
      updated_at:
          map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TenantRoomDataModel.fromJson(String source) =>
      TenantRoomDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
