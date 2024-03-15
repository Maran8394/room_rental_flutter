// tenant_uploaded_document_model.dart

class TenantUploadedDocumentModel {
  final int id;
  final String billType;
  final String billNumber;
  final String units;
  final String billStatus;
  final DateTime createdOn;
  final DateTime updatedOn;

  TenantUploadedDocumentModel({
    required this.id,
    required this.billType,
    required this.billNumber,
    required this.units,
    required this.billStatus,
    required this.createdOn,
    required this.updatedOn,
  });

  factory TenantUploadedDocumentModel.fromJson(Map<String, dynamic> json) {
    return TenantUploadedDocumentModel(
      id: json['id'],
      billType: json['bill_type'],
      billNumber: json['bill_number'],
      units: json['units'],
      billStatus: json['bill_status'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }
}
