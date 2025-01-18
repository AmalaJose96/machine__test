part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailedState extends LoginState {
  final String error;

  const LoginFailedState({required this.error});
}

class LoginSuccessState extends LoginState {
  final LoginResponseModel? response;

  const LoginSuccessState({this.response});
}
