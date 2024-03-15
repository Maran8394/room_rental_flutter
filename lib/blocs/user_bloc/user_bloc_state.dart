part of 'user_bloc_bloc.dart';

@immutable
sealed class UserBlocState {}

final class UserBlocInitial extends UserBlocState {}

class SiginInitState extends UserBlocState{}

class SigninSuccessState extends UserBlocState {
  final LoginResponseModel responseModel;
  SigninSuccessState({
    required this.responseModel,
  });
}

class SigninFailureState extends UserBlocState {
  final LoginResponseModel responseModel;
  SigninFailureState({
    required this.responseModel,
  });
}


class ForgotPasswordInitState extends UserBlocState{}

class ForgotPasswordSuccessState extends UserBlocState {
  final ForgotPasswordResponseModel responseModel;
  ForgotPasswordSuccessState({
    required this.responseModel,
  });
}

class ForgotPasswordFailureState extends UserBlocState {
  final ForgotPasswordResponseModel responseModel;
  ForgotPasswordFailureState({
    required this.responseModel,
  });
}

class ResetPasswordInitState extends UserBlocState{}

class ResetPasswordSuccessState extends UserBlocState {
  final ResetPasswordResponseModel responseModel;
  ResetPasswordSuccessState({
    required this.responseModel,
  });
}

class ResetPasswordFailureState extends UserBlocState {
  final ResetPasswordResponseModel responseModel;
  ResetPasswordFailureState({
    required this.responseModel,
  });
}
