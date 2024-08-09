import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/progress_task_controller.dart';
import '../../data/wrapper/task_model_wrapper.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/background_widget.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';
import 'package:get/get.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xff21BF73),
        onRefresh: () async {
          _initialCall();
        },
        child: GetBuilder<ProgressTaskController>(builder: (controller) {
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
                  taskListModel: controller.progressTaskList,
                  onUpdateTask: () async {
                    _initialCall();
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
          );
        }),
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  void _initialCall() {
    Get.find<ProgressTaskController>().getSomeProgressTask(context);
  }
}
