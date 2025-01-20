import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/auth/pages/singup.dart';
import 'package:handman/presentation/auth/widgets/email_field.dart';
import 'package:handman/presentation/auth/widgets/password_field.dart';
import 'package:handman/presentation/home/pages/home.dart';
import 'package:handman/service_locator.dart';

import '../../../data/model/signin_req_params.dart';
import '../../../service/auth_api_service.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();

  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        var result = await sl<AuthApiService>().signin(SigninReqParams(
          username: _usernameCon.text,
          password: _passwordCon.text,
        ));

        if (!mounted) return;

        result.fold(
          (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
          (data) async {
            if (!mounted) return;
            AppNavigator.pushReplacement(context, HomePage(search: ''));
          },
        );
      },
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signin(),
              const SizedBox(
                height: 50,
              ),
              EmailFieldWidget(emailCon: _usernameCon),
              const SizedBox(
                height: 20,
              ),
              PasswordFieldWidget(passCon: _passwordCon),
              // _password(),
              const SizedBox(
                height: 60,
              ),
              _createAccountButton(),
              const SizedBox(
                height: 20,
              ),
              _signupText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return const Text(
      'Sign In',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: "Don't you have account?",
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign Up',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, SignupPage());
              })
      ]),
    );
  }
}
