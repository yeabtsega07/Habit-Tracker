import 'package:flutter/material.dart';

class NewHabit extends StatefulWidget {
  final Function addHabit;

  NewHabit(this.addHabit);

  @override
  _NewHabitState createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {
  final _habitNameController = TextEditingController();
  final _goalTimeController = TextEditingController();

  void _submitData() {
    if (_goalTimeController.text.isEmpty) {
      return;
    }
    final enteredHabit = _habitNameController.text;
    final enteredGoalTime = _goalTimeController.text;

    if (enteredHabit.isEmpty || enteredGoalTime.isEmpty) {
      return;
    }

    widget.addHabit(
      enteredHabit,
      enteredGoalTime,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Habit Name"),
              controller: _habitNameController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Goal Time"),
              controller: _goalTimeController,
              onSubmitted: (_) => _submitData(),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text("Add Habit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 60, 60, 57),
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
