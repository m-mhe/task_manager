import '../model/saved_user_new_task_data.dart';

class NewTaskModelWrapper {
  String? status;
  List<SavedUserNewTaskData>? data;

  NewTaskModelWrapper({this.status, this.data});

  NewTaskModelWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SavedUserNewTaskData>[];
      json['data'].forEach((v) {
        data!.add(SavedUserNewTaskData.fromJson(v));
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
