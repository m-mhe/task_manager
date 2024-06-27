import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/controller/new_task_controller.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';

import '../../data/model/saved_user_new_task_data.dart';
import '../utility/URLList.dart';

class NewTaskItem extends StatefulWidget {
  const NewTaskItem({super.key, required this.child});
  final Widget child;

  @override
  State<NewTaskItem> createState() => _NewTaskItemState();
}

class _NewTaskItemState extends State<NewTaskItem> {

  List<SavedUserNewTaskData> newTaskList = [];
  bool loading = false;

  @override
  initState() {
    super.initState();
    _getSomeNewTask;
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getSomeNewTask,
      child: Visibility(
        visible: loading==false,
        replacement: Center(child: CircularProgressIndicator(color: Color(0xff21BF73),),),
        child: ListView.builder(
          itemCount: newTaskList.length,
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
                        newTaskList[i].title??''),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.headlineSmall,
                          newTaskList[i].description??''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                          style: Theme.of(context).textTheme.bodySmall,
                          newTaskList[i].createdDate??''),
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
        ),
      ),
    );
  }

  //=====================================Functions=======================================
  Future<void> _getSomeNewTask() async{
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    ApiResponse getDataFromServer = await ApiCall.getResponse(URLList.getNewTask);
    if(getDataFromServer.isSuccess && mounted){
      bottomPopUpMessage(context, 'Loading Success!', showError: false);
      NewTaskModelWrapper newTaskModelWrapper = NewTaskModelWrapper.fromJson(getDataFromServer.responseData);
      newTaskList = newTaskModelWrapper.data??[];
      setState(() {
        loading = false;
      });
    }else{
      if(mounted){
        bottomPopUpMessage(context, 'Loading Failed', showError: true);
      }
    }
  }
}
