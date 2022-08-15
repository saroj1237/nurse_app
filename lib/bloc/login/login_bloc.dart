import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailPassword>((event, emit) async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);
        if (credential.user != null) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          emit(LoginFailure(errorMsg: 'No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          emit(
              LoginFailure(errorMsg: 'Wrong password provided for that user.'));
        }
      } catch (e) {
        emit(LoginFailure());
      }
    });
  }
}
