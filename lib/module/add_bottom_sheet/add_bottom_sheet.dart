import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c12/model/todo_dm.dart';
import 'package:todo_c12/providers/list_provider.dart';
import 'package:todo_c12/utils/extensions/date_time_extensions.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add new todo",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: "Description"),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Select date",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate(),
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addTodoToFirestore();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = (await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)))) ??
        selectedDate;
  }

  void addTodoToFirestore() async {
    CollectionReference todosCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);

    DocumentReference newDocument = todosCollection.doc();

    ///Creates an empty document

    TodoDM todoDM = TodoDM(
        id: newDocument.id,
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
        isDone: false);

    newDocument.set(todoDM.toJson()).timeout(Duration(milliseconds: 500),
        onTimeout: () {
      provider.getTodosFromFirestore();
    });
    Navigator.pop(context);
    //  todosCollection.add(todoDM.toJson());
  }
}
