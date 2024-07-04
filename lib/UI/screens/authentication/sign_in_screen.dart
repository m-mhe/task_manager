import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/email_for_resetting_password_screen.dart';
import 'package:task_manager/UI/screens/authentication/sign_up_screen.dart';
import 'package:task_manager/UI/utility/url_list.dart';
import 'package:task_manager/UI/utility/validator.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/bottom_navigation_bar.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/controller/authentication_controller.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/model/log_in_model.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Sign In',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Kindly enter your email-address!';
                        }
                        if (Validator.emailValidator.hasMatch(v) == false) {
                          return 'Kindly enter valid email-address.';
                        }
                        return null;
                      },
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
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return 'Kindly enter your pass key!';
                        }
                        return null;
                      },
                      controller: _tEcPassword,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: notLoading,
                      replacement: const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Color(0xff21BF73),
                          )),
                      child: ElevatedButton(
                          onPressed: _onTapNewTaskScreen,
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: _onTapEmailVerificationScreen,
                      child: Text(
                        'Forget Password?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(
                              color: Color(0xff21BF73),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpScreen,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
  final TextEditingController _tEcPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool notLoading = true;

  //=======================================================FUNCTIONS=======================================================
  Future<void> signInServer() async {
    setState(() {
      notLoading = false;
    });
    final Map<String, String> userSignInData = {
      "email": _tEcEmail.text,
      "password": _tEcPassword.text
    };
    ApiResponse getServerResponse =
        await ApiCall.postResponse(URLList.logInURL, userSignInData);
    if (getServerResponse.isSuccess == true) {
      if (mounted) {
        LogInModel logInModel =
            LogInModel.fromJson(getServerResponse.responseData);
        await AuthenticationController.saveLogInToken(logInModel.token!);
        await AuthenticationController.saveUserData(logInModel.data!);
        bottomPopUpMessage(
          context,
          'Sign In Success!',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      }
      setState(() {
        notLoading = true;
      });
    } else {
      if (mounted) {
        bottomPopUpMessage(context, 'Kindly check your email or password!',
            showError: true);
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          notLoading = true;
        });
      }
    }
  }

  void _onTapEmailVerificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailForResettingPasswordScreen(),
      ),
    );
  }

  void _onTapSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  Future<void> _onTapNewTaskScreen() async {
    if (_formKey.currentState!.validate()) {
      await signInServer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
    _tEcPassword.dispose();
  }
}
