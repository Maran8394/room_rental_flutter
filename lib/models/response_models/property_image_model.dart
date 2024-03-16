// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class PropertyImageModel {
  int? id;
  String? image_label;
  String? image;
  String? created_on;
  String? updated_on;
  PropertyImageModel({
    this.id,
    this.image_label,
    this.image,
    this.created_on,
    this.updated_on,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_label': image_label,
      'image': image,
      'created_on': created_on,
      'updated_on': updated_on,
    };
  }

  factory PropertyImageModel.fromMap(Map<String, dynamic> map) {
    return PropertyImageModel(
      id: map['id'] != null ? map['id'] as int : null,
      image_label:
          map['image_label'] != null ? map['image_label'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      created_on:
          map['created_on'] != null ? map['created_on'] as String : null,
      updated_on:
          map['updated_on'] != null ? map['updated_on'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyImageModel.fromJson(String source) =>
      PropertyImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
