part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;
  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthEvent {
  final String email, password;
  SignupEvent({required this.email, required this.password});
}
