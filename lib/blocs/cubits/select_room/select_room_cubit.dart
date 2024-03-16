import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';

part 'select_room_state.dart';

class SelectRoomCubit extends Cubit<SelectRoomState> {
  SelectRoomCubit() : super(SelectRoomInitial());

  void getRooms(TenantRentalRecord propertyModel) {
    List<TenantRoomDataModel?>? roomDataModel = propertyModel.room!;
    emit(SelectRoomSuccessState(roomData: roomDataModel));
  }
}
