import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c12/model/todo_dm.dart';
import 'package:todo_c12/module/layout/tabs/list/todo.dart';
import 'package:todo_c12/providers/list_provider.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      provider.getTodosFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
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



  Widget buildTodosList() {
    return ListView.builder(
        itemCount: provider.todos.length,
        itemBuilder: (context, index) {
          return Todo(item: provider.todos[index]);
        });
  }

  Widget buildCalendar(BuildContext context) {
    return EasyDateTimeLine(
      headerProps: const EasyHeaderProps(showHeader: false),
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        provider.selectedDate = selectedDate;
        provider.getTodosFromFirestore();
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
