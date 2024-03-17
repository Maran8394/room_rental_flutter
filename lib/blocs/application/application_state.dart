// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'application_bloc.dart';

class ApplicationState {}

final class ApplicationInitial extends ApplicationState {}

class GetPropertiesInitialState extends ApplicationState {}

class GetPropertiesSuccess extends ApplicationState {
  final TenantRentalRecordList response;
  GetPropertiesSuccess({
    required this.response,
  });
}

class GetPropertiesFailed extends ApplicationState {
  final String errorMessage;
  GetPropertiesFailed({
    required this.errorMessage,
  });
}

class CreateBillInitState extends ApplicationState {}

class CreateBillSuccessState extends ApplicationState {
  final CreateBillResponseData responseData;
  CreateBillSuccessState({
    required this.responseData,
  });
}

class CreateBillFiledState extends ApplicationState {
  final String errorMessage;
  CreateBillFiledState({
    required this.errorMessage,
  });
}

class UserDataUpdateInitState extends ApplicationState {}

class UserDataUpdateDone extends ApplicationState {
  final UserDataModel responseData;
  UserDataUpdateDone({
    required this.responseData,
  });
}

class UserDataUpdateFailed extends ApplicationState {
  final String errorMessage;
  UserDataUpdateFailed({
    required this.errorMessage,
  });
}

class ChangePasswordInit extends ApplicationState {}

class ChangePasswordDone extends ApplicationState {}

class ChangePasswordFailed extends ApplicationState {
  final String errorMessage;
  ChangePasswordFailed({
    required this.errorMessage,
  });
}

class ServiceRequestInit extends ApplicationState {}

class ServiceRequestDone extends ApplicationState {}

class ServiceRequestFailed extends ApplicationState {
  final String errorMessage;
  ServiceRequestFailed({
    required this.errorMessage,
  });
}
