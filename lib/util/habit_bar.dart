import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitBar extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int goalTime;
  final bool habitStarted;

  const HabitBar({
    super.key,
    required this.habitName,
    required this.onTap,
    required this.settingsTapped,
    required this.timeSpent,
    required this.goalTime,
    required this.habitStarted,
  });

  // covert seconds to minutes and seconds
  String convertToMinutes(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsLeft = (seconds % 60).toString();

    if (secondsLeft.length == 1) {
      secondsLeft = "0" + secondsLeft;
    }

    return minutes + ":" + secondsLeft;
  }

  // calcutale progress percentage
  double calculateProgress(int timeSpent, int goalTime) {
    return timeSpent / (goalTime * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 237, 239),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        // progress circle
                        CircularPercentIndicator(
                          radius: 60,
                          percent: calculateProgress(timeSpent, goalTime) < 1
                              ? calculateProgress(timeSpent, goalTime)
                              : 1,
                          progressColor: calculateProgress(
                                      timeSpent, goalTime) >
                                  0.5
                              ? (calculateProgress(timeSpent, goalTime) > 0.75
                                  ? Colors.green
                                  : Colors.amber)
                              : (calculateProgress(timeSpent, goalTime) > 0.25
                                  ? Colors.orange[700]
                                  : Colors.red),
                        ),

                        // play pause  button
                        Center(
                          child: Icon(
                              habitStarted ? Icons.pause : Icons.play_arrow),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit name
                    Text(
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    // progress
                    Text(
                      convertToMinutes(timeSpent) +
                          " / " +
                          goalTime.toString() +
                          " = " +
                          (calculateProgress(timeSpent, goalTime) * 100)
                              .toStringAsFixed(0) +
                          "%",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTapped,
              child: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
