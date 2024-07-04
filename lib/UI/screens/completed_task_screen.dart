import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/task_item.dart';

import '../../data/controller/task_controller.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/snack_bar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<SavedUserTaskData> _completedTaskList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getSomeCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _loading == false,
        replacement: const Center(
          child: CircularProgressIndicator(
            color: Color(0xff21BF73),
          ),
        ),
        child: RefreshIndicator(
          color: const Color(0xff21BF73),
          onRefresh: _getSomeCompletedTask,
          child: BackgroundWidget(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, right: 15, bottom: 10),
              child: NewTaskItem(
                taskListModel: _completedTaskList,
                onUpdateTask: () async {
                  await _getSomeCompletedTask();
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xff21BF73),
                      borderRadius: BorderRadius.circular(80)),
                  child: const Text(
                    "Completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  Future<void> _getSomeCompletedTask() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getCompletedTask);
    if (getDataFromServer.isSuccess && mounted) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _completedTaskList = taskModelWrapper.data ?? [];
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
}
