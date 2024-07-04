import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/canceled_task_screen.dart';
import 'package:task_manager/UI/screens/completed_task_screen.dart';
import 'package:task_manager/UI/screens/new_task_screen.dart';
import 'package:task_manager/UI/screens/progress_task_screen.dart';
import 'package:task_manager/UI/widgets/profile_app_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _screenIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          _screenIndex = i;
          setState(() {});
        },
        currentIndex: _screenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
            ),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
            ),
            label: 'Canceled',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
            ),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
