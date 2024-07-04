import 'package:flutter/material.dart';

import '../../data/controller/task_controller.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/background_widget.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  List<SavedUserTaskData> _canceledTaskList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getSomeCanceledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getSomeCanceledTask,
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
                taskListModel: _canceledTaskList,
                onUpdateTask: () async {
                  await _getSomeCanceledTask();
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(80)),
                  child: const Text(
                    "Canceled",
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
  Future<void> _getSomeCanceledTask() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getCanceledTask);
    if (getDataFromServer.isSuccess && mounted) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _canceledTaskList = taskModelWrapper.data ?? [];
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
