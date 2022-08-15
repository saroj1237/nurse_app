import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurse_app/bloc/signup/signup_bloc.dart';
import 'package:nurse_app/pages/login_page.dart';
import 'package:nurse_app/utils/my_theme.dart';

import '../custom_clippers/custom_clipping.dart';
import '../utils/constants.dart';
import '../utils/fade_slide_transition.dart';
import '../utils/validators.dart';
import '../widgets/header.dart';
import '../widgets/mybutton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _headerTextAnimation;
  Animation<double>? _formElementAnimation;

  GlobalKey<FormState> formKey = GlobalKey();
  bool formValidate = false;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConfirmPassword = FocusNode();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

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
      body: SafeArea(
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
                      additionalOffset: 10,
                      child: _buildConfirmPassword()),
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
                      text: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<SignupBloc>().add(
                              SignupwithEmailPassword(controllerEmail.text,
                                  controllerPassword.text));
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
                            "Already have an account?",
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  CupertinoPageRoute(builder: (context) {
                                return const LoginView();
                              }));
                            },
                            child: const Text(
                              "Login",
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
          ),
        ),
        onFieldSubmitted: (String val) {
          fieldFocusChange(context, focusPassword, focusConfirmPassword);
        });
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
        controller: controllerConfirmPassword,
        validator: fieldValidator,
        keyboardType: TextInputType.visiblePassword,
        obscureText: confirmPasswordVisible,
        focusNode: focusConfirmPassword,
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
            hintText: "Confirm Password",
            hintStyle: TextStyle(
              color: kBlack.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  confirmPasswordVisible = !confirmPasswordVisible;
                });
              },
              icon: confirmPasswordVisible
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
