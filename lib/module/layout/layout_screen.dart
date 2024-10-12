import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c12/module/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_c12/module/layout/tabs/list/list_tab.dart';
import 'package:todo_c12/module/layout/tabs/settings/settings_tab.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName = "layout";
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [const ListTab(), const SettingsTab()];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(theme),
      bottomNavigationBar: buildBottomAppBar(),
      body: tabs[currentIndex],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "ToDo List",
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      toolbarHeight: 100,
    );
  }

  FloatingActionButton buildFab(ThemeData theme) {
    return FloatingActionButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(360),
          borderSide: const BorderSide(color: Colors.white, width: 4)),
      backgroundColor: theme.primaryColor,
      onPressed: () {
        showModalBottomSheet(context: context,
            isScrollControlled: true,
            builder: (context){
          print("MediaQuery.of(context).viewInsets: ${MediaQuery.of(context).viewInsets}");
          return Builder(
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: AddBottomSheet(),
              );
            }
          );
        });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      padding: const EdgeInsets.all(0),
      color: Colors.white,
      notchMargin: 15,
      height: 80,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
          elevation: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30), label: ""),
          ]),
    );
  }
}
