import 'package:flutter/material.dart';

import '../widgets/background_widget.dart';
import '../widgets/new_task_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
          child: NewTaskItem(newTaskListModel: [],
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(80)),
            child: Text(
              "Canceled",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),),
        ),
      ),
    );
  }
}
