
part of "register_bloc.dart";

abstract class RegisterEvents extends Equatable{
  const RegisterEvents();

 @override
  List<Object?> get props => [];
}

class RegisterButtonEvent extends RegisterEvents {
  final String password;
  final String email;
  final String rool;
  final num phone;
  final String name;
  const RegisterButtonEvent( {required this.password, required this.email,required this.rool,required this.name,required this.phone,});

  @override
  List<Object> get props => [password, email,rool,phone,name];
}