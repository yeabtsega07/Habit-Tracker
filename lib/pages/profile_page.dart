import 'package:flutter/material.dart';
import '../models/habit.dart';

class ProfilePage extends StatelessWidget {
  final List<Habit> habitList;

  ProfilePage(this.habitList);

  int get totalHabits => habitList.length;
  int get completedHabits =>
      habitList.where((habit) => habit.timeSpent >= habit.goalTime * 60).length;

  double get completionPercentage =>
      totalHabits == 0 ? 0.0 : completedHabits / totalHabits;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 217, 221),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 32, 35),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://picsum.photos/200'), // Replace with user's avatar image
            ),
            const SizedBox(height: 16),
            const Text(
              'User Name', // Replace with user's name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Completed Habits: $completedHabits / $totalHabits',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    value: completionPercentage,
                    backgroundColor: Colors.grey[300], // Set background color
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(
                        255, 45, 69, 109)), // Set progress bar color
                  ),
                ),
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: completionPercentage == 1.0
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : Text(
                            '${(completionPercentage * 100).toInt()}%',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
