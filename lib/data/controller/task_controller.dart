import '../model/saved_user_task_data.dart';

class TaskModelWrapper {
  String? status;
  List<SavedUserTaskData>? data;

  TaskModelWrapper({this.status, this.data});

  TaskModelWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SavedUserTaskData>[];
      json['data'].forEach((v) {
        data!.add(SavedUserTaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
