import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/service/storage/storage_service.dart';
import 'package:room_rental/utils/constants/storage_keys.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  void getUserData() async {
    String? fullName = await Storage.getValue(StorageKeys.fullName);
    String? firstName = await Storage.getValue(StorageKeys.firstName);
    String? lastName = await Storage.getValue(StorageKeys.lastName);
    String? email = await Storage.getValue(StorageKeys.email);
    String? mobileNo = await Storage.getValue(StorageKeys.phoneNo);
    String? profilePic = await Storage.getValue(StorageKeys.profilePic);

    emit(
      UserData(
        fullName: fullName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNum: mobileNo,
        profilePic: profilePic,
      ),
    );
  }
}
