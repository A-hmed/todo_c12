import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();


  Future<void> getTodosFromFirestore() async {
    CollectionReference todosCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName);

    QuerySnapshot querySnapshot = await todosCollection.orderBy("date").get();

    todos = querySnapshot.docs.map((docSnapshot) {
      Map<String, dynamic> json = docSnapshot.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();

    todos = todos.where((todo){
      return todo.date.day == selectedDate.day &&
          todo.date.month == selectedDate.month &&
          todo.date.year == selectedDate.year;
    }).toList();

    // todos.sort((todo1, todo2){
    //   return todo1.date.compareTo(todo2.date);
    // });
    // setState(() {});
    notifyListeners();
  }
}