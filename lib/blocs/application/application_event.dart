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
  final List<String> imagePath;
  CreateBillEvent({
    required this.requestData,
    required this.imagePath,
  });
}

class UpdateUserDataEvent extends ApplicationEvent {
  final Map<String, dynamic> requestBody;
  UpdateUserDataEvent({
    required this.requestBody,
  });
}

class ChangePasswordEvent extends ApplicationEvent {
  final Map<String, dynamic> requestBody;
  ChangePasswordEvent({
    required this.requestBody,
  });
}

class NewServiceRequestEvent extends ApplicationEvent {
  final Map<String, dynamic> requestData;
  final List<String>? images;
  NewServiceRequestEvent({
    required this.requestData,
    required this.images,
  });
}

class UpdateServiceRequestEvent extends ApplicationEvent {
  final String objectId;
  final Map<String, dynamic> requestData;
  List<String>? images;
  UpdateServiceRequestEvent({
    required this.objectId,
    required this.requestData,
    this.images,
  });
}

class ChangeServiceRequestStatusEvent extends ApplicationEvent {
  final String objectId;
  final Map<String, dynamic> requestData;
  ChangeServiceRequestStatusEvent({
    required this.objectId,
    required this.requestData,
  });
}

class GetServiceRequests extends ApplicationEvent {
  final String? month;
  GetServiceRequests({
    this.month,
  });
}

class GetPaymentPageBillsEvent extends ApplicationEvent {
  final String? month;
  GetPaymentPageBillsEvent({
    this.month,
  });
}

class UpdateBillEvent extends ApplicationEvent {
  final String objectId;
  List<String>? images;
  final Map<String, dynamic> requestData;
  UpdateBillEvent({
    required this.objectId,
    this.images,
    required this.requestData,
  });
}

class GetChartDataEvent extends ApplicationEvent {
   final String? month;
   GetChartDataEvent({
    this.month,
  });
}
