import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c12/model/todo_dm.dart';
import 'package:todo_c12/providers/list_provider.dart';

class Todo extends StatefulWidget {
  final TodoDM item;

  const Todo({super.key, required this.item});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  late ThemeData theme = Theme.of(context);
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          buildDivider(context),
          const SizedBox(
            width: 24,
          ),
          buildTodoInfo(),
          const Spacer(),
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
          color: widget.item.isDone
              ? Colors.green
              : Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10))),
    );
  }

  Widget buildTodoInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item.title,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          widget.item.description,
          style: theme.textTheme.titleSmall,
        )
      ],
    );
  }

  Widget buildTodoState() {
    return InkWell(
      onTap: () async {
        DocumentReference doc = FirebaseFirestore.instance
            .collection(TodoDM.collectionName)
            .doc(widget.item.id);
        doc.update({"isDone": !widget.item.isDone}).timeout(
            Duration(milliseconds: 500), onTimeout: () {
          provider.getTodosFromFirestore();
        });
      },
      child: widget.item.isDone
          ? Text("Done")
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.done,
                color: Colors.white,
              )),
    );
  }
}
