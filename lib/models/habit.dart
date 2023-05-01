import 'package:flutter/foundation.dart';

class Habit {
  final String name;
  bool isStarted;
  int timeSpent;
  final int goalTime;

  Habit({
    required this.name,
    this.isStarted = false,
    this.timeSpent = 0,
    required this.goalTime,
  });
}
