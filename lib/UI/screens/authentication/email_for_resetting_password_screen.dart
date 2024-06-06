import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/pin_for_resetting_password_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';

class EmailForResettingPasswordScreen extends StatefulWidget {
  const EmailForResettingPasswordScreen({super.key});

  @override
  State<EmailForResettingPasswordScreen> createState() => _EmailForResettingPasswordScreenState();
}

class _EmailForResettingPasswordScreenState extends State<EmailForResettingPasswordScreen> {

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
                    'Insert Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),Text(
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
                  ElevatedButton(
                      onPressed: _onTapPinVerificationScreen,
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
                          recognizer: TapGestureRecognizer()..onTap = _onTapSignInScreen,
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

  //=======================================================FUNCTIONS=======================================================
  void _onTapSignInScreen(){
    Navigator.pop(context);
  }
  void _onTapPinVerificationScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return const PinForResettingPasswordScreen();}));
  }

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
  }
}
