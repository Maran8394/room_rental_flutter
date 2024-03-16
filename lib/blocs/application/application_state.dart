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
