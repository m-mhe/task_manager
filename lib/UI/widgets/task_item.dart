import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/model/api_response.dart';
import 'package:task_manager/data/network_caller/api_call.dart';
import '../../data/model/saved_user_task_data.dart';
import '../utility/url_list.dart';

class NewTaskItem extends StatefulWidget {
  const NewTaskItem(
      {super.key,
      required this.child,
      required this.taskListModel,
      required this.onUpdateTask});

  final Widget child;
  final List<SavedUserTaskData> taskListModel;
  final VoidCallback onUpdateTask;

  @override
  State<NewTaskItem> createState() => _NewTaskItemState();
}

class _NewTaskItemState extends State<NewTaskItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskListModel.length,
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
                    widget.taskListModel[i].title ?? ''),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headlineSmall,
                      widget.taskListModel[i].description ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                      style: Theme.of(context).textTheme.bodySmall,
                      widget.taskListModel[i].createdDate ?? ''),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.child,
                    Row(
                      children: [
                        Visibility(
                          visible: _statusEditInProcess == false,
                          replacement: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Color(0xff21BF73),
                              )),
                          child: IconButton(
                            onPressed: () {
                              _onPressEditStatus(widget.taskListModel[i].sId!);
                            },
                            icon: const Icon(
                              Icons.edit_note_outlined,
                              color: Color(0xff21BF73),
                              size: 24,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _deleteInProcess == false,
                          replacement: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Color(0xff21BF73),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _onPressDeleteTask(
                                  widget.taskListModel[i].sId.toString());
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
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

  //=====================================Variables=======================================
  bool _deleteInProcess = false;
  bool _statusEditInProcess = false;

  //=====================================Functions=======================================
  void _onPressEditStatus(String iD) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            actions: [
              Center(
                  child: TextButton(
                onPressed: () async {
                  setState(() {
                    _statusEditInProcess = true;
                  });
                  ApiResponse getResponseFromServer = await ApiCall.getResponse(
                      URLList.updateStatus('$iD/New'));
                  if (getResponseFromServer.isSuccess && mounted) {
                    widget.onUpdateTask();
                    bottomPopUpMessage(context, 'Task Status Updated!');
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  } else {
                    bottomPopUpMessage(context,
                        'Something Went wrong while updating task status.',
                        showError: true);
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  }
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )),
              Center(
                  child: TextButton(
                onPressed: () async {
                  setState(() {
                    _statusEditInProcess = true;
                  });
                  ApiResponse getResponseFromServer = await ApiCall.getResponse(
                      URLList.updateStatus('$iD/Completed'));
                  if (getResponseFromServer.isSuccess && mounted) {
                    widget.onUpdateTask();
                    bottomPopUpMessage(context, 'Task Status Updated!');
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  } else {
                    bottomPopUpMessage(context,
                        'Something Went wrong while updating task status.',
                        showError: true);
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  }
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff21BF73),
                    foregroundColor: Colors.white),
                child: const Text(
                  'COMPLETED',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )),
              Center(
                  child: TextButton(
                onPressed: () async {
                  setState(() {
                    _statusEditInProcess = true;
                  });
                  ApiResponse getResponseFromServer = await ApiCall.getResponse(
                      URLList.updateStatus('$iD/Canceled'));
                  if (getResponseFromServer.isSuccess && mounted) {
                    widget.onUpdateTask();
                    bottomPopUpMessage(context, 'Task Status Updated!');
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  } else {
                    bottomPopUpMessage(context,
                        'Something Went wrong while updating task status.',
                        showError: true);
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  }
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text(
                  'CANCELED',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )),
              Center(
                  child: TextButton(
                onPressed: () async {
                  setState(() {
                    _statusEditInProcess = true;
                  });
                  ApiResponse getResponseFromServer = await ApiCall.getResponse(
                      URLList.updateStatus('$iD/Progress'));
                  if (getResponseFromServer.isSuccess && mounted) {
                    widget.onUpdateTask();
                    bottomPopUpMessage(context, 'Task Status Updated!');
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  } else {
                    if (mounted) {
                      bottomPopUpMessage(context,
                          'Something Went wrong while updating task status.',
                          showError: true);
                    }
                    setState(() {
                      _statusEditInProcess = false;
                    });
                  }
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
                child: const Text(
                  'PROGRESS',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              )),
            ],
          );
        });
  }

  Future<void> _onPressDeleteTask(String iD) async {
    setState(() {
      _deleteInProcess = true;
    });
    ApiResponse getResponseFromServer =
        await ApiCall.getResponse(URLList.deleteTask(iD));
    if (getResponseFromServer.isSuccess && mounted) {
      bottomPopUpMessage(context, 'Delete Successful!');
      widget.onUpdateTask();
    } else {
      if (mounted) {
        bottomPopUpMessage(
            context, 'Something Went wrong while deleting the task.',
            showError: true);
      }
      await Future.delayed(const Duration(seconds: 02));
      setState(() {
        _deleteInProcess = false;
      });
    }
  }

//======================================Widgets========================================
}
