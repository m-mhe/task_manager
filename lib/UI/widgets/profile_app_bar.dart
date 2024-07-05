import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/sign_in_screen.dart';
import 'package:task_manager/UI/screens/authentication/update_profile_screen.dart';
import 'package:task_manager/data/controller/authentication_controller.dart';

AppBar profileAppBar(context, [bool isItUpdateProfileScreen = false]) {
  return AppBar(
    leading: InkWell(
      onTap: () {
        if (isItUpdateProfileScreen == true) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: MemoryImage(
                  base64Decode(AuthenticationController.userData?.photo ??
                      ''),
                ),
                fit: BoxFit.cover,
              )),
        ),
      ),
    ),
    title: InkWell(
      onTap: () {
        if (isItUpdateProfileScreen == true) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ('${AuthenticationController.userData!.firstName ?? ''} ${AuthenticationController.userData!.lastName ?? ''}'),
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            AuthenticationController.userData!.email ?? '',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            AuthenticationController.clearLogInCache();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false);
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
