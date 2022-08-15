part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginWithEmailPassword with LoginEvent {
  final String email;
  final String password;
  LoginWithEmailPassword(this.email, this.password);
}
