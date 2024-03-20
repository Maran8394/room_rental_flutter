// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ServiceRequestFile {
  String? file;
  int? id;
  ServiceRequestFile({
    this.file,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
      'id': id,
    };
  }

  factory ServiceRequestFile.fromMap(Map<String, dynamic> map) {
    return ServiceRequestFile(
      file: map['file'] != null ? map['file'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestFile.fromJson(String source) =>
      ServiceRequestFile.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ServiceRequestModel {
  int? id;
  List<ServiceRequestFile>? files;
  String? service_type;
  String? catergory;
  String? priority;
  String? description;
  String? request_status;
  dynamic service_charge;
  bool? is_it_paid;
  dynamic created_on;
  dynamic updated_on;
  int? tenant_rental_record;
  ServiceRequestModel({
    this.id,
    this.files,
    this.service_type,
    this.catergory,
    this.priority,
    this.description,
    this.request_status,
    required this.service_charge,
    this.is_it_paid,
    required this.created_on,
    required this.updated_on,
    this.tenant_rental_record,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'files': files!.map((x) => x.toMap()).toList(),
      'service_type': service_type,
      'catergory': catergory,
      'priority': priority,
      'description': description,
      'request_status': request_status,
      'service_charge': service_charge,
      'is_it_paid': is_it_paid,
      'created_on': created_on,
      'updated_on': updated_on,
      'tenant_rental_record': tenant_rental_record,
    };
  }

  factory ServiceRequestModel.fromMap(Map<String, dynamic> map) {
    return ServiceRequestModel(
      id: map['id'] != null ? map['id'] as int : null,
      files: map['files'] != null
          ? List<ServiceRequestFile>.from(
              (map['files'] as List<dynamic>).map<ServiceRequestFile?>(
                (x) => ServiceRequestFile.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      service_type:
          map['service_type'] != null ? map['service_type'] as String : null,
      catergory: map['catergory'] != null ? map['catergory'] as String : null,
      priority: map['priority'] != null ? map['priority'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      request_status: map['request_status'] != null
          ? map['request_status'] as String
          : null,
      service_charge: map['service_charge'] as dynamic,
      is_it_paid: map['is_it_paid'] != null ? map['is_it_paid'] as bool : null,
      created_on: map['created_on'] as dynamic,
      updated_on: map['updated_on'] as dynamic,
      tenant_rental_record: map['tenant_rental_record'] != null
          ? map['tenant_rental_record'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestModel.fromJson(String source) =>
      ServiceRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
