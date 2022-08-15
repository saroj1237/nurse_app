import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurse_app/bloc/auth/auth_cubit.dart';
import 'package:nurse_app/bloc/login/login_bloc.dart';
import 'package:nurse_app/bloc/signup/signup_bloc.dart';
import 'package:nurse_app/pages/landing_page.dart';
import 'package:nurse_app/pages/login_page.dart';
import 'package:nurse_app/push_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService().setupInteractedMessage();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fibaseAuth = FirebaseAuth.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(fibaseAuth)..checkAuthState(),
        ),
        BlocProvider(
          create: (_) => SignupBloc(fibaseAuth),
        ),
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: state is Authenticated
                ? const LandingPage()
                : state is UnAuthenticated
                    ? const LoginView()
                    : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
