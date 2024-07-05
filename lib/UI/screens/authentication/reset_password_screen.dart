import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/utility/url_list.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  final String email;
  final String otp;

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
                    obscureText: true,
                    controller: _tEcPassword,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _tEcConfirmPassword,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: _loading == false,
                    replacement: const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Color(0xff21BF73),
                      ),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          if (_tEcPassword.text == _tEcConfirmPassword.text) {
                            Map<String, dynamic> userInfoAndNewPassword = {
                              "email": widget.email,
                              "OTP": widget.otp,
                              "password": _tEcConfirmPassword.text,
                            };
                            ApiResponse setNewPassword =
                                await ApiCall.postResponse(
                                    URLList.reSetPassword,
                                    userInfoAndNewPassword);
                            if (setNewPassword.isSuccess &&
                                mounted &&
                                setNewPassword.responseData['status'] ==
                                    'success') {
                              bottomPopUpMessage(context,
                                  'Now you can login with your new password!');
                              Navigator.pop(context);
                            } else {
                              if (mounted) {
                                bottomPopUpMessage(
                                    context, 'Something went wrong',
                                    showError: true);
                                await Future.delayed(
                                    const Duration(seconds: 02));
                                setState(() {
                                  _loading = false;
                                });
                              }
                            }
                          } else {
                            bottomPopUpMessage(
                                context, "Password doesn't match",
                                showError: true);
                            await Future.delayed(const Duration(seconds: 02));
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: const Text('CONFIRM')),
                  ),
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
  bool _loading = false;

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
