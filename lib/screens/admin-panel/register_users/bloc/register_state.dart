part of "register_bloc.dart";
class RegisterState extends Equatable{
  

  RegisterState(
      {this.email = '',
      this.password = '',
      this.name = "",
      this.phone = 0,
      this.message = '',
      this.registerStatus = RegisterStatus.initail,});
  
  final String email;
  final String password;
  final String message;
  final String name;
  final num phone;
  final RegisterStatus registerStatus;

  RegisterState copyWith({
    String? email,
    String? password,
    String? message,
    String? name,
    num? phone,
    RegisterStatus? registerStatus,
  }) {
    return RegisterState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      registerStatus: registerStatus ?? this.registerStatus,
      
    );
  }

  @override
  List<Object> get props => [email, password, message, registerStatus,name,phone];


}

