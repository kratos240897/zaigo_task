part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginFailState extends LoginState {
  final String message;

  LoginFailState({required this.message});
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}
