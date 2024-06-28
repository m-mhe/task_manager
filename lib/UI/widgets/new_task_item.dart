import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/controller/new_task_controller.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

import '../../data/model/saved_user_new_task_data.dart';
import '../utility/URLList.dart';

class NewTaskItem extends StatefulWidget {
  const NewTaskItem({super.key, required this.child, required this.newTaskListModel});
  final Widget child;
  final List<SavedUserNewTaskData> newTaskListModel;

  @override
  State<NewTaskItem> createState() => _NewTaskItemState();
}

class _NewTaskItemState extends State<NewTaskItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.newTaskListModel.length,
      itemBuilder: (context, i) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          color: Colors.white,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    style: Theme.of(context).textTheme.headlineMedium,
                    widget.newTaskListModel[i].title??''),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headlineSmall,
                      widget.newTaskListModel[i].description??''),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                      style: Theme.of(context).textTheme.bodySmall,
                      widget.newTaskListModel[i].createdDate??''),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.child,
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined, color: Color(0xff21BF73),size: 24,),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline, color: Colors.red,size: 24,),),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //=====================================Functions=======================================

}
