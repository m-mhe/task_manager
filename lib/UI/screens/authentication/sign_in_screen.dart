import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/email_for_resetting_password_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _tEcEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tEcPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.arrow_circle_right_outlined)),
                  SizedBox(
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
                          style: TextStyle(
                            color: Color(0xff21BF73),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
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
  final TextEditingController _tEcEmail = TextEditingController();
  final TextEditingController _tEcPassword = TextEditingController();

  //=======================================================FUNCTIONS=======================================================
  void _onTapEmailVerificationScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailForResettingPasswordScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
    _tEcPassword.dispose();
  }
}
