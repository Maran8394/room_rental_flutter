part of 'user_bloc_bloc.dart';

@immutable
sealed class UserBlocEvent {}

class SigninEvent extends UserBlocEvent {
  final String userName;
  final String password;
  SigninEvent({
    required this.userName,
    required this.password,
  });
}

class ForgotPasswordEvent extends UserBlocEvent {
  final String userName;
  ForgotPasswordEvent({
    required this.userName,
  });
}

class ResetPasswordEvent extends UserBlocEvent {
  final String userName;
  final String password;
  ResetPasswordEvent({
    required this.userName,
    required this.password,
  });
}


