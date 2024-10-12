import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c12/module/layout/tabs/list/todo.dart';

class TodoDM {
  static const String collectionName = "todos";
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  TodoDM(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone});

  TodoDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp timestamp = json["date"];
    date = timestamp.toDate();
    isDone = json["isDone"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }
}
