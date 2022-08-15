part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {}

class SignUpFailure extends SignupState {
  final String errorMsg;
  SignUpFailure({this.errorMsg = 'Error occured'});
}
