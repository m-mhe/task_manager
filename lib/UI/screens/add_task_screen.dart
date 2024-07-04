import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/profile_app_bar.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/bottom_navigation_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
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
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _tEcSubject,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'You have to add a subject to your task.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tEcDescription,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'Please add some description.';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 7,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: _notLoading == true,
                    replacement: const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Color(0xff21BF73),
                        )),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _notLoading = false;
                          if (mounted) {
                            setState(() {});
                          }
                          final Map<String, String> userResponse = {
                            "title": _tEcSubject.text.trim(),
                            "description": _tEcDescription.text.trim(),
                            "status": "New"
                          };
                          ApiResponse getResponseFromTheServer =
                              await ApiCall.postResponse(
                                  URLList.createTask, userResponse);
                          if (getResponseFromTheServer.isSuccess && mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavBar()),
                                (route) => false);
                            bottomPopUpMessage(context, 'A New Task Added!',
                                showError: false);
                          } else {
                            if (mounted) {
                              setState(() {
                                bottomPopUpMessage(context,
                                    'Error occurred while adding a new task. Check internet connection and try again',
                                    showError: true);
                              });
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() {
                                _notLoading = true;
                              });
                            }
                          }
                        }
                      },
                      child: const Text('Add'),
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
    );
  }
  @override
  void dispose() {
    super.dispose();
    _tEcDescription.dispose();
    _tEcSubject.dispose();
  }

  //=======================================================VARIABLES=======================================================
  final TextEditingController _tEcSubject = TextEditingController();
  final TextEditingController _tEcDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _notLoading = true;

//=======================================================Functions=======================================================
}
