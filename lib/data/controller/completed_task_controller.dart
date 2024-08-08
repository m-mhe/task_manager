import 'package:get/get.dart';
import 'package:task_manager/data/model/saved_user_task_data.dart';
import '../../UI/utility/url_list.dart';
import '../model/api_response.dart';
import '../network_caller/api_call.dart';
import '../wrapper/task_model_wrapper.dart';

class CompletedTaskController extends GetxController{
  bool _loading = false;
  List<SavedUserTaskData> _completedTaskList = [];
  List<SavedUserTaskData> get completedTaskList => _completedTaskList;
  bool get loading=> _loading;

  Future<void> getSomeCompletedTask() async {
    _loading = true;
    update();
    ApiResponse getDataFromServer =
    await ApiCall.getResponse(URLList.getCompletedTask);
    if (getDataFromServer.isSuccess) {
      TaskModelWrapper taskModelWrapper =
      TaskModelWrapper.fromJson(getDataFromServer.responseData);
      _completedTaskList = taskModelWrapper.data ?? [];
      _loading = false;
      update();
    } else {
        await Future.delayed(const Duration(seconds: 2));
        _loading = false;
        update();
    }
  }
}