import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/add_task_screen.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';

import '../../data/controller/new_task_controller.dart';
import '../../data/model/api_response.dart';
import '../../data/model/saved_user_new_task_data.dart';
import '../../data/network_caller/api_call.dart';
import '../utility/URLList.dart';
import '../widgets/new_task_item.dart';
import '../widgets/snack_bar_message.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<SavedUserNewTaskData> newTaskList = [];
  bool loading = false;

  @override
  initState() {
    super.initState();
    _getSomeNewTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Color(0xff21BF73),
        onRefresh: _getSomeNewTask,
        child: Visibility(
          visible: loading==false,
          replacement: Center(child: CircularProgressIndicator(color: Color(0xff21BF73),),),
          child: BackgroundWidget(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _summaryCard(number: '110', title: 'New Task'),
                        _summaryCard(number: '86', title: 'Completed'),
                        _summaryCard(number: '09', title: 'Canceled'),
                        _summaryCard(number: '18', title: 'Progress'),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  Expanded(child: NewTaskItem(newTaskListModel: newTaskList,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(80)),
                    child: Text(
                      "New",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),),),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onPressAddTaskScreen, child: Icon(Icons.add),),
    );
  }

  //=======================================================FUNCTIONS=======================================================
  void _onPressAddTaskScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen(),),);
  }
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

  //=======================================================WIDGETS=======================================================
  Widget _summaryCard({required String number, required String title}) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: SizedBox(
        width: 120,
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    );
  }
}
