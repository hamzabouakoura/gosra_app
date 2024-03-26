part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class BlocLoginLoading extends AuthState {}

class BlocLoginSuccess extends AuthState {}

class BlocLoginFailure extends AuthState {
  BlocLoginFailure(this.error);
  String error;
}

class BlocSignupLoading extends AuthState {}

class BlocSignupSuccess extends AuthState {}

class BlocSignupFailure extends AuthState {
  String error;
  BlocSignupFailure(this.error);
}
