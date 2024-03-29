// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'application_bloc.dart';

class ApplicationState {}

final class ApplicationInitial extends ApplicationState {}

class GetPropertiesInitialState extends ApplicationState {}

class GetServiceRequestInit extends ApplicationState {}

class GetServiceRequestDone extends ApplicationState {
  final ServiceRequestListData responseData;
  GetServiceRequestDone({
    required this.responseData,
  });
}

class GetBillsInit extends ApplicationState {}

class GetBillsDone extends ApplicationState {
  final PaymentPageModel responseData;
  GetBillsDone({
    required this.responseData,
  });
}

class GetBillsFailed extends ApplicationState {
  final String errorMessage;
  GetBillsFailed({
    required this.errorMessage,
  });
}

class GetServiceRequestFailed extends ApplicationState {
  final String errorMessage;
  GetServiceRequestFailed({
    required this.errorMessage,
  });
}

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

class CreateBillSuccessState extends ApplicationState {}

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

class UpdateServiceRequestInit extends ApplicationState {}

class UpdateServiceRequestDone extends ApplicationState {}

class UpdateServiceRequestFailed extends ApplicationState {
  final String errorMessage;
  UpdateServiceRequestFailed({
    required this.errorMessage,
  });
}

class ChangeServiceRequestStatusInit extends ApplicationState {}

class ChangeServiceRequestStatusDone extends ApplicationState {}

class ChangeServiceRequestStatusFailed extends ApplicationState {
  final String errorMessage;
  ChangeServiceRequestStatusFailed({
    required this.errorMessage,
  });
}

class UpdateBillInitState extends ApplicationState {}

class UpdateBillDoneState extends ApplicationState {}

class UpdateBillFailedState extends ApplicationState {
  final String errorMessage;
  UpdateBillFailedState({
    required this.errorMessage,
  });
}

class GetChartDataInitState extends ApplicationState {}

class GetChartDataDoneState extends ApplicationState {
  DashboardChartData responseData;
  GetChartDataDoneState({
    required this.responseData,
  });
}

class GetChartDataFailedState extends ApplicationState {
  final String errorMessage;
  GetChartDataFailedState({
    required this.errorMessage,
  });
}

class GetNotificationsInitState extends ApplicationState {}

class GetNotificationsDoneState extends ApplicationState {
  final NotificationsModel responseData;
  GetNotificationsDoneState({
    required this.responseData,
  });
}

class GetNotificationsFailedState extends ApplicationState {
  final String errorMessage;
  GetNotificationsFailedState({
    required this.errorMessage,
  });
}
