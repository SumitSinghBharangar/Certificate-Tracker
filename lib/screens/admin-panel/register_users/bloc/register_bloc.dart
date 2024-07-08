import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gla_certificate/repositories/register_repository.dart';

import '../../../../utils/enum.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterState>{
RegisterRepo registerRepo;
  RegisterBloc({required this.registerRepo}):super(RegisterState()){
    on<RegisterButtonEvent>(registerButtonEvent);

  }


  FutureOr<void> registerButtonEvent(RegisterButtonEvent event, Emitter<RegisterState> emit)async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    User? user = await registerRepo.signUp(event.email, event.password, event.rool,event.rool,event.phone);
    if (user != null) {
      emit(state.copyWith(
          registerStatus: RegisterStatus.success, message: "User Register Succesful"));
    } else {
      emit(state.copyWith(
          registerStatus: RegisterStatus.error, message: "error Occured"));
    }

  }
}