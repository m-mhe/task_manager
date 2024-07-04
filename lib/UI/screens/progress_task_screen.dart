import 'package:flutter/material.dart';
import '../../data/controller/task_controller.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/background_widget.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<SavedUserTaskData> _progressTaskList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getSomeProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getSomeProgressTask,
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
              child: NewTaskItem(
                taskListModel: _progressTaskList,
                onUpdateTask: () async {
                  await _getSomeProgressTask();
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(80)),
                  child: const Text(
                    "Progress",
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
  Future<void> _getSomeProgressTask() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getProgressTask);
    if (getDataFromServer.isSuccess && mounted) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _progressTaskList = taskModelWrapper.data ?? [];
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
