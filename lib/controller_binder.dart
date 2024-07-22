import 'package:get/get.dart';
import 'package:task_manager/data/controller/sign_in_controller.dart';

import 'data/controller/new_task_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SignInController(), fenix: true);
    Get.lazyPut(()=>NewTaskController(), fenix: true);
  }
}