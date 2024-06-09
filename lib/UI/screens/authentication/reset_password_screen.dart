import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/sign_in_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                  top: MediaQuery.sizeOf(context).height / 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Set New Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Minimum length of password should be 8 character, Try to mixed with letter and spacial characters',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
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
                  TextFormField(
                    controller: _tEcConfirmPassword,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('CONFIRM')),
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
  final TextEditingController _tEcConfirmPassword = TextEditingController();
  final TextEditingController _tEcPassword = TextEditingController();

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _tEcConfirmPassword.dispose();
    _tEcPassword.dispose();
  }
}
