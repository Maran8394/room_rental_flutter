// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'application_bloc.dart';

class ApplicationEvent {}

class SendServiceRequestEvent extends ApplicationEvent {
  final String serviceType;
  final String serviceCategory;
  final String priority;
  final String description;
  final String tenantId;
  final String propertyId;
  final String referenceDocument;
  SendServiceRequestEvent({
    required this.serviceType,
    required this.serviceCategory,
    required this.priority,
    required this.description,
    required this.tenantId,
    required this.propertyId,
    required this.referenceDocument,
  });
}

class GetPropertiesEvent extends ApplicationEvent {}

class CreateBillEvent extends ApplicationEvent {
  final Map<String, dynamic> requestData;
  final String imagePath;
  CreateBillEvent({
    required this.requestData,
    required this.imagePath,
  });
}
