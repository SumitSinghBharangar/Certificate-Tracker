part of "login_bloc.dart";

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object?> get props => [];
}

class EnableDisableVisibility extends LoginEvents {}

class LoginButtonEvent extends LoginEvents {
  final String password;
  final String email;
  const LoginButtonEvent({required this.password, required this.email});

  @override
  List<Object> get props => [password, email];
}
