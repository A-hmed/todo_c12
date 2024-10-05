import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  static const String routeName = "layout";
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: const BorderSide(color: Colors.white, width: 4)),
        backgroundColor: theme.primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        color: Colors.white,
        notchMargin: 15,
        height: 80,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
      ),
      body: Column(
        children: [
          Stack(
            // alignment: const Alignment(0, 2),
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, left: 30),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: theme.primaryColor),
                child: const Text(
                  "ToDo List",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: EasyDateTimeLine(
                  headerProps: const EasyHeaderProps(showHeader: false),
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                  },
                  activeColor: theme.primaryColor,
                  dayProps: EasyDayProps(
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: Colors.white,
                      inactiveDayStyle: DayStyle(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
