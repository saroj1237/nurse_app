import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurse_app/bloc/login/login_bloc.dart';
import 'package:nurse_app/pages/signup_page.dart';
import 'package:nurse_app/utils/my_theme.dart';

import '../custom_clippers/custom_clipping.dart';
import '../utils/constants.dart';
import '../utils/fade_slide_transition.dart';
import '../utils/my_styles.dart';
import '../utils/validators.dart';
import '../widgets/header.dart';
import '../widgets/mybutton.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _headerTextAnimation;
  Animation<double>? _formElementAnimation;

  GlobalKey<FormState> formKey = GlobalKey();
  bool formValidate = false;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool passwordVisible = true;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    _animationController!.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhite,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipPath(
                          clipper: CustomClipping(),
                          child: Container(
                              height: 175,
                              width: MediaQuery.of(context).size.width,
                              color: MyTheme.themeColor)),
                      Header(
                        animation: _headerTextAnimation!,
                        isLogin: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: FadeSlideTransition(
                        animation: _formElementAnimation!,
                        additionalOffset: 0.0,
                        child: _buildEmail()),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: FadeSlideTransition(
                        animation: _formElementAnimation!,
                        additionalOffset: 10,
                        child: _buildPassword()),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: FadeSlideTransition(
                      animation: _formElementAnimation!,
                      additionalOffset: 2 * 10.0,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Forgot Password?",
                                style: forgotPasswordStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: FadeSlideTransition(
                      animation: _formElementAnimation!,
                      additionalOffset: 2 * 10.0,
                      child: CustomButton(
                        color: MyTheme.themeColor,
                        textColor: kWhite,
                        text: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<LoginBloc>().add(
                                  LoginWithEmailPassword(controllerEmail.text,
                                      controllerPassword.text),
                                );
                          } else {}
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: FadeSlideTransition(
                      animation: _formElementAnimation!,
                      additionalOffset: 2 * 10.0,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignupPage();
                                }));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2 * 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
        controller: controllerEmail,
        validator: fieldValidator,
        keyboardType: TextInputType.emailAddress,
        focusNode: focusEmail,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(kPaddingM),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyTheme.themeColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.12),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.5),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green.withOpacity(0.5),
            ),
          ),
          hintText: "Email",
          hintStyle: TextStyle(
            color: kBlack.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.black45,
          ),
        ),
        onFieldSubmitted: (String val) {
          fieldFocusChange(context, focusEmail, focusPassword);
        });
  }

  Widget _buildPassword() {
    return TextFormField(
        controller: controllerPassword,
        validator: fieldValidator,
        keyboardType: TextInputType.emailAddress,
        obscureText: passwordVisible,
        focusNode: focusPassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(kPaddingM),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyTheme.themeColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.12),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green.withOpacity(0.5),
              ),
            ),
            hintText: "Password",
            hintStyle: TextStyle(
              color: kBlack.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: passwordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.black45,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.black54,
                    ),
            ),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black45,
            )));
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
