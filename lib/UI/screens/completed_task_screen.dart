import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/task_item.dart';
import 'package:task_manager/data/controller/completed_task_controller.dart';

import '../../data/wrapper/task_model_wrapper.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/url_list.dart';
import '../widgets/snack_bar_message.dart';
import 'package:get/get.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.loading == false,
            replacement: const Center(
              child: CircularProgressIndicator(
                color: Color(0xff21BF73),
              ),
            ),
            child: RefreshIndicator(
              color: const Color(0xff21BF73),
              onRefresh: _initialize,
              child: BackgroundWidget(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, right: 15, bottom: 10),
                  child: TaskItem(
                    taskListModel:
                        controller.completedTaskList.reversed.toList(),
                    onUpdateTask: () async {
                      await _initialize();
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
          );
        },
      ),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  Future<void> _initialize() async {
    Get.find<CompletedTaskController>().getSomeCompletedTask();
  }
}
