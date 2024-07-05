import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/reset_password_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/model/api_response.dart';
import '../../../data/network_caller/api_call.dart';
import '../../utility/url_list.dart';
import '../../widgets/snack_bar_message.dart';

class PinForResettingPasswordScreen extends StatefulWidget {
  const PinForResettingPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<PinForResettingPasswordScreen> createState() =>
      _PinForResettingPasswordScreenState();
}

class _PinForResettingPasswordScreenState
    extends State<PinForResettingPasswordScreen> {
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
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'A six digit verification pin has been send to your email address.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: MediaQuery.sizeOf(context).width / 9,
                        fieldWidth: MediaQuery.sizeOf(context).width / 9,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: const Color(0xff21BF73),
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.white),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    controller: _tEcPin,
                    onCompleted: (v) {},
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
                        onPressed: _onTapSetPasswordScreen,
                        child: const Text('VERIFY')),
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
  final TextEditingController _tEcPin = TextEditingController();
  bool _loading = false;

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen() {
    Navigator.pop(context);
  }

  Future<void> _onTapSetPasswordScreen() async {
    setState(() {
      _loading = true;
    });
    ApiResponse getResponseFromServer = await ApiCall.getResponse(
        URLList.otpResettingPassword('${widget.email}/${_tEcPin.text}'));
    if (getResponseFromServer.isSuccess &&
        mounted &&
        getResponseFromServer.responseData['status'] == 'success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                    email: widget.email,
                    otp: _tEcPin.text,
                  )));
    } else {
      if (mounted) {
        bottomPopUpMessage(context, 'Wrong input', showError: true);
        await Future.delayed(const Duration(seconds: 02));
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tEcPin.dispose();
  }
}
