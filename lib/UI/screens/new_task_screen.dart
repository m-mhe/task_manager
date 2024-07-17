import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/UI/screens/add_task_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/data/controller/new_task_controller.dart';
import 'package:task_manager/data/controller/task_status_model_wrapper.dart';
import 'package:task_manager/data/model/task_status_model.dart';
import '../../data/model/api_response.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/task_item.dart';
import '../widgets/snack_bar_message.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskStatusModel> _taskStatusList = [];
  bool _loading =false;

  @override
  initState() {
    super.initState();
    _initialCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xff21BF73),
        onRefresh: () async {
          _initialCall();
        },
        child: GetBuilder<NewTaskController>(
          builder: (taskController) {
            return Visibility(
              visible: taskController.loading == false,
              replacement: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff21BF73),
                ),
              ),
              child: BackgroundWidget(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _taskStatusList.map((e) {
                            return _summaryCard(
                                number: e.sum.toString(),
                                title: (e.sId ?? 'unknown').toUpperCase());
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Expanded(
                        child: NewTaskItem(
                          taskListModel: taskController.newTaskList.reversed.toList(),
                          onUpdateTask: () async {
                            _initialCall();
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(80)),
                            child: const Text(
                              "New",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressAddTaskScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  void _initialCall(){
    _getTaskStatus();
    Get.find<NewTaskController>().getSomeNewTask(context: context);
  }

  void _onPressAddTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  }

  Future<void> _getTaskStatus() async {
    setState(() {
      _loading = true;
    });
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getStatus);
    if (getDataFromServer.isSuccess) {
      TaskStatusModelWrapper taskStatusModelWrapper =
          TaskStatusModelWrapper.fromJson(getDataFromServer.responseData);
      _taskStatusList = taskStatusModelWrapper.data ?? [];
      setState(() {
        _loading = false;
      });
    } else {
      if (mounted) {
        bottomPopUpMessage(context, 'Error occur while loading task status',
            showError: true);
        setState(() {
          _loading = false;
        });
      }
    }
  }

  //=======================================================WIDGETS=======================================================
  Widget _summaryCard({required String number, required String title}) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: SizedBox(
        width: 120,
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
