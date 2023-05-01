import 'dart:async';

import "package:flutter/material.dart";
import './util/habit_bar.dart';
import '../models/habit.dart';
import '../widgets/new_habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // habit summary
  List<Habit> habitList = [
    // [habitName, habitStarted, timeSpent(sec), goalTime(min)],
    // ["Pray", false, 0, 20],
    // ["Exercise", false, 0, 10],
    // ["Read", false, 0, 20],
    // ["Code", false, 0, 40],
  ];

  List<Habit> get recentHabit {
    return habitList.where((habit) {
      return habit.timeSpent > 0;
    }).toList();
  }

  void addNewHabit(String habitName, String goalTime) {
    final newHabit = Habit(
      name: habitName,
      goalTime: int.parse(goalTime),
      isStarted: false,
      timeSpent: 0,
    );

    setState(() {
      habitList.add(newHabit);
    });
  }

  void startAddNewHabit(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewHabit(addNewHabit),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteHabit(String name) {
    setState(() {
      habitList.removeWhere((habit) => habit.name == name);
    });
  }

  void habitStarted(int index) {
    var startTime = DateTime.now();

    // get the current time
    int elapsedTime = habitList[index].timeSpent;

    // habit started or stopped
    setState(() {
      habitList[index].isStarted = !habitList[index].isStarted;
    });

    if (habitList[index].isStarted) {
      // keep the time going!
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // when the timer is stopped
          if (habitList[index].isStarted == false) {
            timer.cancel();
          }

          // get the time elapsed
          var currentTime = DateTime.now();
          habitList[index].timeSpent = elapsedTime +
              (currentTime.second -
                  startTime.second +
                  60 * (currentTime.minute - startTime.minute) +
                  60 * 60 * (currentTime.hour - startTime.hour));
        });
      });
    }
  }

  void settingsTapped(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Settings for ' + habitList[index].name),
          content: Text('Delete or edit the habit.'),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteHabit(habitList[index].name);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 217, 221),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 32, 35),
        title: Text("Consistency is key."),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewHabit(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitBar(
            habitName: habitList[index].name,
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsTapped(index);
            },
            habitStarted: habitList[index].isStarted,
            timeSpent: habitList[index].timeSpent,
            goalTime: habitList[index].goalTime,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 26, 32, 35),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => startAddNewHabit(context),
      ),
    );
  }
}
