import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:task_manager/data/controller/canceled_task_controller.dart';

import '../../data/wrapper/task_model_wrapper.dart';
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

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _initialize,
        child: GetBuilder<CanceledTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.loading == false,
              replacement: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff21BF73),
                ),
              ),
              child: BackgroundWidget(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, right: 15, bottom: 10),
                  child: TaskItem(
                    taskListModel: controller.canceledTaskList,
                    onUpdateTask: () async {
                      await _initialize();
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
            );
          }
        ),
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  Future<void> _initialize() async {
    Get.find<CanceledTaskController>().getSomeCanceledTask(context);
  }
}
