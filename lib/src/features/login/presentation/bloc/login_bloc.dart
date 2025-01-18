// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/src/features/login/data/models/login_request.dart';
import 'package:machine_test/src/features/login/data/models/login_response_model.dart';
import 'package:machine_test/src/features/login/data/models/repo_response.dart';
import 'package:machine_test/src/features/login/domain/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc(
    this.authRepo,
  ) : super(LoginInitial()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
      OnLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      final RepoResponse<LoginResponseModel> response =
          await authRepo.onLogin(event.loginRequest);
      if (response.isSuccess) {
        if (response.response?.status == 'ERROR') {
          switch (response.response?.errorCode ?? '') {
            case '7513':
              emit(LoginFailedState(
                  error:
                      'Error code ${response.response?.errorCode}: Empty Username'));
            case '6271':
              emit(LoginFailedState(
                  error:
                      'Error code ${response.response?.errorCode}: Empty password'));
            case '5435':
              emit(LoginFailedState(
                  error:
                      'Error code ${response.response?.errorCode}: Wrong access token'));
            case '4897':
              emit(LoginFailedState(
                  error:
                      'Error code ${response.response?.errorCode}: Invalid username or password'));

            default:
              emit(LoginFailedState(
                  error:
                      'Error code ${response.response?.errorCode}: Unknown error'));
          }
        } else {
          emit(LoginSuccessState(response: response.response));
        }
      } else {
        emit(const LoginFailedState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(LoginFailedState(error: "Something went wrong\n${e.toString()}"));
    }
  }
}
