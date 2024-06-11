import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/background_widget.dart';
import 'package:task_manager/UI/widgets/task_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
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
              Expanded(child: TaskItem(child: Container(
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
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
    );
  }

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
