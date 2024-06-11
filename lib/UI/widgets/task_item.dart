import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
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
                    'Task Title'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headlineSmall,
                      "Task Description: The completion of the artificial insemination proce, artificial insemination can be carried out only if the request of the infertile couple is not older than six months"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                      style: Theme.of(context).textTheme.bodySmall,
                      'Date: 10/ 12/ 2024'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    child,
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
}
