part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLoginEvent extends LoginEvent {
  final LoginRequest loginRequest;

  const OnLoginEvent({required this.loginRequest});
}
