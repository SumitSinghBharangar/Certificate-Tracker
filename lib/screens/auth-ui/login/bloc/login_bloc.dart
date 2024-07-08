import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gla_certificate/repositories/login_repository.dart';

import '../../../../utils/enum.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginRepo loginRepo;
  LoginBloc({required this.loginRepo}) : super(LoginState()) {
    on<LoginButtonEvent>(_LoginButtonEvent);
    on<EnableDisableVisibility>(
      (event, emit) {
        emit(state.copyWith(isVisible: !state.isVisible));
      },
    );
  }

  FutureOr<void> _LoginButtonEvent(
      LoginButtonEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    User? user = await loginRepo.signInMethod(event.email, event.password);
    if (user != null) {
      emit(state.copyWith(
          loginStatus: LoginStatus.success, message: "login Succesful"));
    } else {
      emit(state.copyWith(
          loginStatus: LoginStatus.error, message: "error Occured"));
    }
  }
}
