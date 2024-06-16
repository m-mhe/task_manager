import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/utility/URLList.dart';
import 'package:task_manager/UI/utility/validator.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

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
              child: Form(
                key: _formKey,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Please enter your First Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _tEcLName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Please enter your Last Name';
                        } else {
                          return null;
                        }
                      },
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Please enter your Mobile Number';
                        }
                        if (Validator.mobileNumberValidator.hasMatch(v) ==
                            false) {
                          return 'Please a valid Mobile Number';
                        }
                        return null;
                      },
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Please enter your Email Address';
                        }
                        if (Validator.emailValidator.hasMatch(v) == false) {
                          return 'Please a valid Email Address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _tEcPassword,
                      obscureText: _hidePass,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Please enter a Password';
                        }
                        if (v.length < 8) {
                          return 'Your Password should contain 8 character or more';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                          icon: _hidePass
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _registerUserInputToServer();
                          }
                        },
                        child: Visibility(
                            visible: _registrationInProgress == false,
                            replacement: const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ))),
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
      ),
    );
  }

  //=======================================================VARIABLES=======================================================
  final TextEditingController _tEcEmail = TextEditingController();
  final TextEditingController _tEcFName = TextEditingController();
  final TextEditingController _tEcLName = TextEditingController();
  final TextEditingController _tEcMobile = TextEditingController();
  final TextEditingController _tEcPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _registrationInProgress = false;
  bool _hidePass = true;

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen() {
    Navigator.pop(context);
  }

  Future<void> _registerUserInputToServer() async {
    if (mounted) {
      setState(
        () {
          _registrationInProgress = true;
        },
      );
    }
    Map<String, String> userRegInfo = {
      "email": _tEcEmail.text,
      "firstName": _tEcFName.text,
      "lastName": _tEcLName.text,
      "mobile": _tEcMobile.text,
      "password": _tEcPassword.text,
      "photo": "",
    };
    ApiResponse serverResponse =
        await ApiCall.postResponse(URLList.registrationURL, userRegInfo);
    if (serverResponse.isSuccess == true && mounted) {
      bottomPopUpMessage(context,
          "REGISTRATION ${serverResponse.responseData.values.toList()[0].toString().toUpperCase()}!",
          showError: false);
      Navigator.pop(context);
    } else {
      if (mounted) {
        bottomPopUpMessage(
            context,
            serverResponse.errorMessage ??
                'Registration failed! Please try again.');
      }
    }
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
