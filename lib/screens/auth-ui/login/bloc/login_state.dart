part of 'login_bloc.dart';
// ignore: must_be_immutable
class LoginState extends Equatable {
  

  LoginState(
      {this.email = '',
      this.password = '',
      this.isVisible = false,
      this.message = '',
      this.loginStatus = LoginStatus.initail});
  bool isVisible;
  final String email;
  final String password;
  final String message;
  final LoginStatus loginStatus;

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
    bool? isVisible,
    LoginStatus? loginStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object> get props => [email, password, message, loginStatus,isVisible];
}
