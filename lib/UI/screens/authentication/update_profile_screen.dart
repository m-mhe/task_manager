import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/UI/utility/url_list.dart';
import 'package:task_manager/UI/utility/validator.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/bottom_navigation_bar.dart';
import 'package:task_manager/UI/widgets/profile_app_bar.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/controller/authentication_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/model/user_data_model.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width / 10,
                  right: MediaQuery.sizeOf(context).width / 10,
                  top: MediaQuery.sizeOf(context).height / 9),
              child: Form(
                key: _formKeyUpdateProfile,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Update Your Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: _onPressGetImg,
                            child: Container(
                              height: 54,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    bottomLeft: Radius.circular(7)),
                              ),
                              child: Text(
                                'Photos',
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _imageOfUser?.name ?? 'Select an image',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v == null) {
                          return 'Please enter your Phone Number';
                        } else if (Validator.mobileNumberValidator
                                .hasMatch(v) ==
                            false) {
                          return 'Please enter a valid Phone Number';
                        } else {
                          return null;
                        }
                      },
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
                      enabled: false,
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
                      controller: _tEcPassword,
                      decoration: const InputDecoration(
                        hintText: 'Password',
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
                          onPressed: _onPressUpdateProfile,
                          child: const Icon(Icons.arrow_circle_right_outlined)),
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

  @override
  void dispose() {
    super.dispose();
    _tEcEmail.dispose();
    _tEcPassword.dispose();
    _tEcFName.dispose();
    _tEcLName.dispose();
    _tEcMobile.dispose();
  }

  //=======================================================VARIABLES=======================================================
  final TextEditingController _tEcEmail = TextEditingController(
      text: AuthenticationController.userData!.email ?? '');
  final TextEditingController _tEcFName = TextEditingController(
      text: AuthenticationController.userData!.firstName ?? '');
  final TextEditingController _tEcLName = TextEditingController(
      text: AuthenticationController.userData!.lastName ?? '');
  final TextEditingController _tEcMobile = TextEditingController(
      text: AuthenticationController.userData!.mobile ?? '');
  final TextEditingController _tEcPassword = TextEditingController();
  final GlobalKey<FormState> _formKeyUpdateProfile = GlobalKey<FormState>();
  XFile? _imageOfUser;
  bool _loading = false;

  //=======================================================FUNCTIONS=======================================================
  Future<void> _onPressGetImg() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageOfUser = image;
    }
    setState(() {});
  }

  Future<void> _onPressUpdateProfile() async {
    setState(() {
      _loading = true;
    });
    String encodedImg = AuthenticationController.userData?.photo ?? '';
    if (_formKeyUpdateProfile.currentState!.validate()) {
      Map<String, dynamic> userDataForUpdate = {
        "email": _tEcEmail.text,
        "firstName": _tEcFName.text,
        "lastName": _tEcLName.text,
        "mobile": _tEcMobile.text,
      };
      if (_tEcPassword.text.isNotEmpty) {
        userDataForUpdate["password"] = _tEcPassword.text;
      }
      if (_imageOfUser != null) {
        File file = File(_imageOfUser!.path);
        encodedImg = base64Encode(file.readAsBytesSync());
        userDataForUpdate["photo"] = encodedImg;
      }
      ApiResponse updateProfile =
          await ApiCall.postResponse(URLList.upDateProfile, userDataForUpdate);
      if (updateProfile.isSuccess &&
          mounted &&
          updateProfile.responseData['status'] == 'success') {
        UserDataModel userDataModel = UserDataModel(
            email: _tEcEmail.text,
            photo: encodedImg,
            firstName: _tEcFName.text,
            lastName: _tEcLName.text,
            mobile: _tEcMobile.text);
        await AuthenticationController.saveUserData(userDataModel);
        bottomPopUpMessage(context, 'Profile Updated!');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
            (route) => false);
      } else {
        if (mounted) {
          bottomPopUpMessage(context, 'Something went wrong', showError: true);
          await Future.delayed(const Duration(seconds: 02));
          setState(() {
            _loading = false;
          });
        }
      }
    }
  }
}
