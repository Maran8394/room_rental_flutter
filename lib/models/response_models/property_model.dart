// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:room_rental/models/response_models/property_image_model.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';

class PropertyModel {
  int? id;
  String? property_name;
  String? type;
  String? status;
  String? property_price;
  String? deposit_amount;
  String? address;
  String? description;
  Map? amenities;
  bool? is_available;
  String? created_on;
  String? updated_on;
  List<TenantRoomDataModel?>? rooms;
  List<PropertyImageModel?>? images;
  PropertyModel({
    this.id,
    this.property_name,
    this.type,
    this.status,
    this.property_price,
    this.deposit_amount,
    this.address,
    this.description,
    this.amenities,
    this.is_available,
    this.created_on,
    this.updated_on,
    this.rooms,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'property_name': property_name,
      'type': type,
      'status': status,
      'property_price': property_price,
      'deposit_amount': deposit_amount,
      'address': address,
      'description': description,
      'amenities':
          amenities != null ? Map<String, dynamic>.from(amenities!) : null,
      'is_available': is_available,
      'created_on': created_on,
      'updated_on': updated_on,
      'rooms': rooms!.map((x) => x?.toMap()).toList(),
      'images': images!.map((x) => x?.toMap()).toList(),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'] != null ? map['id'] as int : null,
      property_name:
          map['property_name'] != null ? map['property_name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      property_price: map['property_price'] != null
          ? map['property_price'] as String
          : null,
      deposit_amount: map['deposit_amount'] != null
          ? map['deposit_amount'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      amenities: map['amenities'] != null
          ? Map.from(map['amenities'] as Map<String, dynamic>)
          : null,
      is_available:
          map['is_available'] != null ? map['is_available'] as bool : null,
      created_on:
          map['created_on'] != null ? map['created_on'] as String : null,
      updated_on:
          map['updated_on'] != null ? map['updated_on'] as String : null,
      rooms: map['rooms'] != null
          ? List<TenantRoomDataModel?>.from(
              (map['rooms'] as List<dynamic>).map<TenantRoomDataModel?>(
                (x) => TenantRoomDataModel?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      images: map['images'] != null
          ? List<PropertyImageModel?>.from(
              (map['images'] as List<dynamic>).map<PropertyImageModel?>(
                (x) => PropertyImageModel?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PropertiesList {
  final List<PropertyModel>? response_data;
  PropertiesList({
    this.response_data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'response_data': response_data!.map((x) => x.toMap()).toList(),
    };
  }

  factory PropertiesList.fromMap(Map<String, dynamic> map) {
    return PropertiesList(
      response_data: map['response_data'] != null
          ? List<PropertyModel>.from(
              (map['response_data'] as List<dynamic>).map<PropertyModel?>(
                (x) => PropertyModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertiesList.fromJson(String source) =>
      PropertiesList.fromMap(json.decode(source) as Map<String, dynamic>);
}
