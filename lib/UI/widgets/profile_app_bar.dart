import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/network_image.dart';

AppBar profileAppBar(){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage('https://images.pexels.com/users/avatars/291180653/momin-hosan-emon-255.jpeg?auto=compress&fit=crop&h=130&w=130&dpr=1')
          )
        ),

      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Muhammad Emon', style: TextStyle(fontSize: 18),),
        Text('mominhasanemon@gmail.com', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
      ],
    ),
    actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.logout))
    ],
  );
}
