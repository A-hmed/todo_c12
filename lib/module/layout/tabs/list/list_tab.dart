import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c12/model/todo_dm.dart';
import 'package:todo_c12/module/layout/tabs/list/todo.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if(todos.isEmpty) {
      getTodosFromFirestore();
    }
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        buildCalendarBackground(theme, context),
        Expanded(
          flex: 82,
          child: buildTodosList(),
        )
      ],
    );
  }

  void getTodosFromFirestore() async {
    CollectionReference todosCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);

    QuerySnapshot querySnapshot = await todosCollection.orderBy("date").get();

    todos = querySnapshot.docs.map((docSnapshot) {
      Map<String, dynamic> json = docSnapshot.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();

    todos = todos.where((todo){
      return todo.date.day == selectedDate.day && todo.date.month == selectedDate.month &&
       todo.date.year == selectedDate.year;
    }).toList();

    // todos.sort((todo1, todo2){
    //   return todo1.date.compareTo(todo2.date);
    // });
    setState(() {});
  }

  Widget buildTodosList() {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Todo(item: todos[index]);
        });
  }

  Widget buildCalendar(BuildContext context) {
    return EasyDateTimeLine(
      headerProps: const EasyHeaderProps(showHeader: false),
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        this.selectedDate = selectedDate;
        getTodosFromFirestore();
      },
      activeColor: Theme.of(context).primaryColor,
      dayProps: EasyDayProps(
          todayHighlightStyle: TodayHighlightStyle.withBackground,
          todayHighlightColor: Colors.white,
          inactiveDayStyle: DayStyle(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14)))),
    );
  }

  Expanded buildCalendarBackground(ThemeData theme, BuildContext context) {
    return Expanded(
        flex: 18,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  color: theme.primaryColor,
                )),
                Spacer(),
              ],
            ),
            buildCalendar(context),
          ],
        ));
  }
}
