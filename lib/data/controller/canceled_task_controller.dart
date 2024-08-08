import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model/saved_user_task_data.dart';

import '../../UI/utility/url_list.dart';
import '../../UI/widgets/snack_bar_message.dart';
import '../model/api_response.dart';
import '../network_caller/api_call.dart';
import '../wrapper/task_model_wrapper.dart';

class CanceledTaskController extends GetxController{
  bool _loading = false;
  List<SavedUserTaskData> _canceledTaskList = [];
  bool get loading => _loading;
  List<SavedUserTaskData> get canceledTaskList {
    return _canceledTaskList;
  }
  Future<void> getSomeCanceledTask(final BuildContext context) async {
    _loading = true;
    update();
    ApiResponse getDataFromServer =
    await ApiCall.getResponse(URLList.getCanceledTask);
    if (getDataFromServer.isSuccess) {
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      TaskModelWrapper taskModelWrapper =
      TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _canceledTaskList = taskModelWrapper.data ?? [];
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