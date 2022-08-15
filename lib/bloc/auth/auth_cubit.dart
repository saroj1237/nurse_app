import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth;
  late StreamSubscription<User?> authSubscription;
  AuthCubit(this.firebaseAuth) : super(AuthInitial()) {
    authSubscription = firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        emit(UnAuthenticated());
      } else {
        print('User is signed in!');
        emit(Authenticated(user));
      }
    });
  }
  void checkAuthState() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      // // Name, email address, and profile photo URL
      // final name = user.displayName;
      // final email = user.email;
      // final photoUrl = user.photoURL;

      // // Check if user's email is verified
      // final emailVerified = user.emailVerified;

      // // The user's ID, unique to the Firebase project. Do NOT use this value to
      // // authenticate with your backend server, if you have one. Use
      // // User.getIdToken() instead.
      // final uid = user.uid;
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  void logOut() async {
    await firebaseAuth.signOut();
    emit(UnAuthenticated());
  }
}
