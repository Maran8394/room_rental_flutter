import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/models/response_models/dashboard_chart_data.dart';
import 'package:room_rental/models/response_models/payment_page_model.dart';
import 'package:room_rental/models/response_models/service_request_list.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/network/models/response_models/change_password_model.dart';
import 'package:room_rental/network/models/response_models/user_data_model.dart';
import 'package:room_rental/network/repo/user_repo.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<GetPropertiesEvent>((event, emit) async {
      emit(GetPropertiesInitialState());
      try {
        UserRepo repo = UserRepo();
        TenantRentalRecordList? responseData = await repo.getProperties();
        emit(GetPropertiesSuccess(response: responseData!));
      } catch (e) {
        emit(GetPropertiesFailed(errorMessage: e.toString().substring(11)));
      }
    });

    on<GetServiceRequests>((event, emit) async {
      emit(GetServiceRequestInit());
      try {
        UserRepo repo = UserRepo();
        ServiceRequestListData? responseData = await repo.getServiceRequests(
          month: event.month,
        );
        emit(GetServiceRequestDone(responseData: responseData!));
      } catch (e) {
        emit(GetServiceRequestFailed(errorMessage: e.toString().substring(11)));
      }
    });

    on<GetPaymentPageBillsEvent>((event, emit) async {
      emit(GetBillsInit());
      try {
        UserRepo repo = UserRepo();
        PaymentPageModel? responseData =
            await repo.getBills(month: event.month);
        emit(GetBillsDone(responseData: responseData!));
      } catch (e) {
        emit(GetBillsFailed(errorMessage: e.toString().substring(11)));
      }
    });

    on<CreateBillEvent>((event, emit) async {
      emit(CreateBillInitState());
      try {
        UserRepo repo = UserRepo();
        await repo.createBill(
          imageFiles: event.imagePath,
          requestBody: event.requestData,
        );
        emit(CreateBillSuccessState());
      } catch (e) {
        emit(CreateBillFiledState(errorMessage: e.toString()));
      }
    });

    on<NewServiceRequestEvent>((event, emit) async {
      emit(ServiceRequestInit());
      try {
        UserRepo repo = UserRepo();
        await repo.newServiceRequest(
          imageFiles: event.images!,
          requestBody: event.requestData,
        );
        emit(ServiceRequestDone());
      } catch (e) {
        emit(ServiceRequestFailed(errorMessage: e.toString()));
      }
    });

    on<UpdateServiceRequestEvent>((event, emit) async {
      emit(UpdateServiceRequestInit());
      try {
        UserRepo repo = UserRepo();
        await repo.updateServiceRequest(
          objectId: event.objectId,
          imageFiles: event.images!,
          requestBody: event.requestData,
        );
        emit(UpdateServiceRequestDone());
      } catch (e) {
        emit(UpdateServiceRequestFailed(errorMessage: e.toString()));
      }
    });

    on<ChangeServiceRequestStatusEvent>((event, emit) async {
      emit(ChangeServiceRequestStatusInit());
      try {
        UserRepo repo = UserRepo();
        await repo.changeServiceRequestStatus(
          objectId: event.objectId,
          requestBody: event.requestData,
        );
        emit(ChangeServiceRequestStatusDone());
      } catch (e) {
        emit(ChangeServiceRequestStatusFailed(errorMessage: e.toString()));
      }
    });

    on<UpdateUserDataEvent>((event, emit) async {
      emit(UserDataUpdateInitState());
      try {
        UserRepo repo = UserRepo();
        UserDataModel? responseData = await repo.updateUserData(
          requestBody: event.requestBody,
        );
        emit(UserDataUpdateDone(responseData: responseData));
      } catch (e) {
        emit(UserDataUpdateFailed(errorMessage: e.toString()));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(UserDataUpdateInitState());
      try {
        UserRepo repo = UserRepo();
        ChangePasswordResponseModel responseData = await repo.changePassword(
          requestBody: event.requestBody,
        );
        if (responseData.data!.status == true) {
          emit(ChangePasswordDone());
        } else {
          if (responseData.data!.has_errors!) {
            emit(
              ChangePasswordFailed(
                  errorMessage: responseData.errors!.first!.message!),
            );
          } else {
            emit(ChangePasswordFailed(errorMessage: responseData.error!));
          }
        }
      } catch (e) {
        emit(ChangePasswordFailed(errorMessage: e.toString()));
      }
    });

    on<UpdateBillEvent>((event, emit) async {
      emit(UpdateBillInitState());
      try {
        UserRepo repo = UserRepo();
        await repo.updateBill(
          requestBody: event.requestData,
          objectId: event.objectId,
          imageFiles: event.images!,
        );
        emit(UpdateBillDoneState());
      } catch (e) {
        emit(UpdateBillFailedState(errorMessage: e.toString()));
      }
    });

    on<GetChartDataEvent>((event, emit) async {
      emit(GetChartDataInitState());
      try {
        UserRepo repo = UserRepo();
        DashboardChartData? data = await repo.getChartData(month: event.month);
        emit(GetChartDataDoneState(responseData: data!));
      } catch (e) {
        emit(GetChartDataFailedState(errorMessage: e.toString()));
      }
    });
  }
}
