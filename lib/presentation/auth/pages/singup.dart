import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/data/model/signup_req_params.dart';
import 'package:handman/presentation/auth/pages/singin.dart';
import 'package:handman/presentation/auth/widgets/password_field.dart';
import 'package:handman/service/auth_api_service.dart';
import 'package:handman/service_locator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        var result = await sl<AuthApiService>().signup(SignupReqParams(
          email: _emailCon.text,
          password: _passwordCon.text,
          username: _usernameCon.text,
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
            AppNavigator.pushReplacement(context, SigninPage());
          },
        );
      },
      child: Text(
        'Sing up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _usernameCon = TextEditingController();

  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signup(),
              const SizedBox(height: 50),
              _userNameField(),
              const SizedBox(height: 20),
              _emailField(),
              const SizedBox(height: 20),
              PasswordFieldWidget(passCon: _passwordCon),
              const SizedBox(height: 60),
              _createAccountButton(),
              const SizedBox(height: 20),
              _signinText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup() {
    return const Text(
      'Sign Up',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _userNameField() {
    return TextField(
      controller: _usernameCon,
      decoration: const InputDecoration(hintText: 'Username'),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: 'Do you have account?',
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign In',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, SigninPage());
              })
      ]),
    );
  }
}
