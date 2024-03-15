// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:room_rental/network/models/request_models/forgot_password_request_model.dart';
import 'package:room_rental/network/models/request_models/login_request_model.dart';
import 'package:room_rental/network/models/request_models/reset_password_request_model.dart';
import 'package:room_rental/network/models/response_models/forgot_password_response_model.dart';
import 'package:room_rental/network/models/response_models/login_response_model.dart';
import 'package:room_rental/network/models/response_models/reset_password_response_model.dart';
import 'package:room_rental/network/repo/user_repo.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepo userRepo;
  UserBloc(this.userRepo) : super(UserBlocInitial()) {
    on<UserBlocEvent>((event, emit) {});

    // signin
    on<SigninEvent>((event, emit) async {
      LoginRequestModel requestModel = LoginRequestModel(
        email: event.userName,
        password: event.password,
      );
      emit(SiginInitState());
      LoginResponseModel responseModel =
          await userRepo.login(requestModel.toMap());
      if (responseModel.successCode == 200) {
        emit(SigninSuccessState(responseModel: responseModel));
      } else {
        emit(SigninFailureState(responseModel: responseModel));
      }
    });

    // ForgotPassword
    on<ForgotPasswordEvent>((event, emit) async {
      ForgotPasswordRequestModel requestModel = ForgotPasswordRequestModel(
        userName: event.userName,
      );
      emit(ForgotPasswordInitState());
      ForgotPasswordResponseModel responseModel =
          await userRepo.forgotPassword(requestModel.toMap());
      if (responseModel.successCode == 200) {
        emit(ForgotPasswordSuccessState(responseModel: responseModel));
      } else {
        emit(ForgotPasswordFailureState(responseModel: responseModel));
      }
    });

    // ResetPassword
    on<ResetPasswordEvent>((event, emit) async {
      ResetPasswordRequestModel requestModel = ResetPasswordRequestModel(
        user_name: event.userName,
        password: event.password,
      );
      emit(ResetPasswordInitState());
      ResetPasswordResponseModel responseModel =
          await userRepo.resetPassword(requestModel.toMap());
      if (responseModel.successCode == 200) {
        emit(ResetPasswordSuccessState(responseModel: responseModel));
      } else {
        emit(ResetPasswordFailureState(responseModel: responseModel));
      }
    });
  }
}
