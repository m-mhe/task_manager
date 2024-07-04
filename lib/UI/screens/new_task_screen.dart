import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/add_task_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/data/controller/task_status_model_wrapper.dart';
import 'package:task_manager/data/model/task_status_model.dart';

import '../../data/controller/task_controller.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
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
  List<SavedUserTaskData> _newTaskList = [];
  List<TaskStatusModel> _taskStatusList = [];
  bool _loading = false;

  @override
  initState() {
    super.initState();
    _getTaskStatus();
    _getSomeNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xff21BF73),
        onRefresh: () async {
          _getSomeNewTask();
          _getTaskStatus();
        },
        child: Visibility(
          visible: _loading == false,
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
                      taskListModel: _newTaskList.reversed.toList(),
                      onUpdateTask: () async {
                        await _getTaskStatus();
                        await _getSomeNewTask();
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressAddTaskScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  void _onPressAddTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  }

  Future<void> _getSomeNewTask() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getNewTask);
    if (getDataFromServer.isSuccess && mounted) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper newTaskModelWrapper =
          TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _newTaskList = newTaskModelWrapper.data ?? [];
      setState(() {
        _loading = false;
      });
    } else {
      if (mounted) {
        bottomPopUpMessage(context, 'Loading Failed', showError: true);
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          _loading = false;
        });
      }
    }
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
