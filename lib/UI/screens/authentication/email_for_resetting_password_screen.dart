import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/pin_for_resetting_password_screen.dart';
import 'package:task_manager/UI/utility/url_list.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

class EmailForResettingPasswordScreen extends StatefulWidget {
  const EmailForResettingPasswordScreen({super.key});

  @override
  State<EmailForResettingPasswordScreen> createState() =>
      _EmailForResettingPasswordScreenState();
}

class _EmailForResettingPasswordScreenState
    extends State<EmailForResettingPasswordScreen> {
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
                    'Insert Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'A six digit verification pin will be send to your email address.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
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
                  Visibility(
                    visible: _loading == false,
                    replacement: const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Color(0xff21BF73),
                        )),
                    child: ElevatedButton(
                        onPressed: _onTapPinVerificationScreen,
                        child: const Icon(Icons.arrow_circle_right_outlined)),
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

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
  }

  //=======================================================VARIABLES=======================================================
  final TextEditingController _tEcEmail = TextEditingController();
  bool _loading = false;

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen() {
    Navigator.pop(context);
  }

  Future<void> _onTapPinVerificationScreen() async {
    setState(() {
      _loading = true;
    });
    ApiResponse getResponseFromServer = await ApiCall.getResponse(
        URLList.emailForResettingPassword(_tEcEmail.text.trim()));
    if (getResponseFromServer.isSuccess &&
        mounted &&
        getResponseFromServer.responseData['status'] == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PinForResettingPasswordScreen(
              email: _tEcEmail.text.trim(),
            );
          },
        ),
      );
    } else {
      if (mounted) {
        bottomPopUpMessage(context, 'There is no such user', showError: true);
        await Future.delayed(const Duration(seconds: 02));
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
