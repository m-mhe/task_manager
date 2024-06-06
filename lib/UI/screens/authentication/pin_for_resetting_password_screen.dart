import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/reset_password_screen.dart';
import 'package:task_manager/UI/screens/authentication/sign_in_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinForResettingPasswordScreen extends StatefulWidget {
  const PinForResettingPasswordScreen({super.key});

  @override
  State<PinForResettingPasswordScreen> createState() => _PinForResettingPasswordScreenState();
}

class _PinForResettingPasswordScreenState extends State<PinForResettingPasswordScreen> {

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
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),Text(
                    'A six digit verification pin has been send to your email address.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(7),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Color(0xff21BF73),
                      inactiveColor: Colors.grey,
                      inactiveFillColor: Colors.white
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    controller: _tEcPin,
                    onCompleted: (v) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSetPasswordScreen,
                      child: Text('VERIFY')),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: ' Sign in',
                          style: TextStyle(
                            color: Color(0xff21BF73),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _onTapSignInScreen,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return SignInScreen();}), (route){return false;});
  }
  void _onTapSetPasswordScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _tEcPin.dispose();
  }
}
