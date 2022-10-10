part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginInitEvent({required this.email, required this.password});
}
