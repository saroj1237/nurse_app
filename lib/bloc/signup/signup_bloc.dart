import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth firebaseAuth;
  SignupBloc(this.firebaseAuth) : super(SignupInitial()) {
    on<SignupwithEmailPassword>((event, emit) async {
      emit(SignUpLoading());
      try {
        final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (credential.user != null) {
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailure());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          emit(SignUpFailure(errorMsg: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          emit(SignUpFailure(
              errorMsg: 'The account already exists for that email.'));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
