// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'select_room_cubit.dart';

class SelectRoomState {}

final class SelectRoomInitial extends SelectRoomState {}

class SelectRoomSuccessState extends SelectRoomState {
  List<TenantRoomDataModel?>? roomData;
  SelectRoomSuccessState({
    this.roomData,
  });
}
