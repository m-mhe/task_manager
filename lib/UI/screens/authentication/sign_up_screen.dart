import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/pin_for_resetting_password_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width / 10,
                  right: MediaQuery.sizeOf(context).width / 10,
                  top: MediaQuery.sizeOf(context).height / 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _tEcFName,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tEcLName,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _tEcMobile,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _tEcEmail,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tEcPassword,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: ' Sign in',
                          style: const TextStyle(
                            color: Color(0xff21BF73),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignInScreen,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //=======================================================VARIABLES=======================================================
  final TextEditingController _tEcEmail = TextEditingController();
  final TextEditingController _tEcFName = TextEditingController();
  final TextEditingController _tEcLName = TextEditingController();
  final TextEditingController _tEcMobile = TextEditingController();
  final TextEditingController _tEcPassword = TextEditingController();

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
    _tEcPassword.dispose();
    _tEcFName.dispose();
    _tEcLName.dispose();
    _tEcMobile.dispose();
  }
}
