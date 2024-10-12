import 'package:flutter/material.dart';
import 'package:todo_c12/model/todo_dm.dart';

class Todo extends StatefulWidget {
  final TodoDM item;

  const Todo({super.key, required this.item});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  late ThemeData theme = Theme.of(context);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          buildDivider(context),
          SizedBox(width: 24,),
          buildTodoInfo(),
          Spacer(),
          buildTodoState()
        ],
      ),
    );
  }

  Widget buildDivider(BuildContext context) {
    return Container(
      height: 62,
      width: 4,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10))),
    );
  }

 Widget buildTodoInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.item.title, style: theme.textTheme.titleMedium,),
        SizedBox(height: 4,),
        Text(widget.item.description, style: theme.textTheme.titleSmall,)
      ],
    );
 }

  Widget buildTodoState() {
    if(widget.item.isDone){
      return Text("Done");
    }else{
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Icon(Icons.done, color: Colors.white,));
    }
  }
}
