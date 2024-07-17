import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/controller/task_model_wrapper.dart';
import 'package:task_manager/data/model/saved_user_task_data.dart';
import '../../UI/utility/url_list.dart';
import '../../UI/widgets/snack_bar_message.dart';
import '../model/api_response.dart';
import '../network_caller/api_call.dart';

class NewTaskController extends GetxController{
  bool _loading = false;
  List<SavedUserTaskData> _newTaskList = [];
  bool get loading => _loading;
  List<SavedUserTaskData> get newTaskList => _newTaskList;

  Future<void> getSomeNewTask({required BuildContext context}) async {
    _loading = true;
    update();
    ApiResponse getDataFromServer =
    await ApiCall.getResponse(URLList.getNewTask);
    if (getDataFromServer.isSuccess) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper newTaskModelWrapper =
      TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _newTaskList = newTaskModelWrapper.data ?? [];
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