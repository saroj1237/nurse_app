part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupwithEmailPassword extends SignupEvent {
  final String email;
  final String password;
  SignupwithEmailPassword(this.email, this.password);
}
