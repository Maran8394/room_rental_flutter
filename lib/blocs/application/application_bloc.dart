import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/models/response_models/create_bill_response_data.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/network/repo/user_repo.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<GetPropertiesEvent>((event, emit) async {
      emit(GetPropertiesInitialState());
      // try {
      UserRepo repo = UserRepo();
      TenantRentalRecordList? responseData = await repo.getProperties();
      emit(GetPropertiesSuccess(response: responseData!));
      // } catch (e) {
      //   emit(GetPropertiesFailed(errorMessage: e.toString().substring(11)));
      // }
    });

    on<CreateBillEvent>((event, emit) async {
      emit(CreateBillInitState());
      // try {
      UserRepo repo = UserRepo();
      CreateBillResponseData? responseData = await repo.createBill(
        imageUrl: event.imagePath,
        requestBody: event.requestData,
      );
      emit(CreateBillSuccessState(responseData: responseData));
      // } catch (e) {
      //   emit(CreateBillFiledState(errorMessage: e.toString()));
      // }
    });
  }
}
