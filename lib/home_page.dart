import 'dart:async';

import "package:flutter/material.dart";
import './util/habit_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // habit summary
  List habitList = [
    // [habitName, habitStarted, timeSpent(sec), goalTime(min)],
    ["Pray", false, 0, 20],
    ["Exercise", false, 0, 10],
    ["Read", false, 0, 20],
    ["Code", false, 0, 40],
  ];

  void habitStarted(int index) {
    var startTime = DateTime.now();

    // get the current time
    int elapsedTime = habitList[index][2];

    // habit started or stopped
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      // keep the time going!
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // when the timer is stopped
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          // get the time elapsed
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
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
          title: Text('Settings for ' + habitList[index][0]),
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
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitBar(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsTapped(index);
            },
            habitStarted: habitList[index][1],
            timeSpent: habitList[index][2],
            goalTime: habitList[index][3],
          );
        },
      ),
    );
  }
}
