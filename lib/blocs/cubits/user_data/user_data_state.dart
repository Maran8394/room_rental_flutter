// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_data_cubit.dart';


class UserDataState {}

final class UserDataInitial extends UserDataState {}

class UserData extends UserDataState {
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNum;
  final String? profilePic;
  UserData({
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNum,
    this.profilePic,
  });
}
