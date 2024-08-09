import 'package:get/get.dart';
import 'package:task_manager/data/model/saved_user_task_data.dart';
import 'package:flutter/material.dart';
import '../../UI/utility/url_list.dart';
import '../../UI/widgets/snack_bar_message.dart';
import '../model/api_response.dart';
import '../network_caller/api_call.dart';
import '../wrapper/task_model_wrapper.dart';

class ProgressTaskController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;
  List<SavedUserTaskData> _progressTaskList = [];

  List<SavedUserTaskData> get progressTaskList => _progressTaskList;

  Future<void> getSomeProgressTask(BuildContext context) async {
    _loading = true;
    update();
    ApiResponse getDataFromServer =
        await ApiCall.getResponse(URLList.getProgressTask);
    if (getDataFromServer.isSuccess) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _progressTaskList = taskModelWrapper.data ?? [];
      _loading = false;
      update();
    } else {
      bottomPopUpMessage(context, 'Loading Failed', showError: true);
      await Future.delayed(const Duration(seconds: 2));
      _loading = false;
      update();
    }
  }
}
