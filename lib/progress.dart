import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_card.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<ExerciseCard> exerciseCards = [];

  void _addNewExercise() {
    setState(() {
      exerciseCards.add(
        ExerciseCard(
          exerciseName: 'New Exercise',
          sets: 3,
          reps: 10,
          weight: 50.0,
          onDelete: _removeExercise,
          onEdit: _editExercise,
        ),
      );
    });
  }

  void _editExercise(ExerciseCard oldCard, String newName, int newSets,
      int newReps, double newWeight) {
    setState(() {
      int index = exerciseCards.indexOf(oldCard);
      exerciseCards[index] = ExerciseCard(
        exerciseName: newName,
        sets: newSets,
        reps: newReps,
        weight: newWeight,
        onDelete: _removeExercise,
        onEdit: _editExercise,
      );
    });
  }

  void _removeExercise(ExerciseCard card) {
    setState(() {
      exerciseCards.remove(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0), // Add padding to shift content down
          child: exerciseCards.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.dumbbell, size: 50, color: Colors.grey),
                SizedBox(height: 20),
                Text('No exercises added. Tap + to add one!'),
              ],
            ),
          )
              : ListView.builder(
            itemCount: exerciseCards.length,
            itemBuilder: (context, index) {
              return exerciseCards[index];
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Color(0xFFB71C1C), // Blood red color
          borderRadius: BorderRadius.circular(16), // Square shape with slightly rounded corners
        ),
        child: FloatingActionButton(
          onPressed: _addNewExercise,
          child: FaIcon(
            FontAwesomeIcons.plus,
            size: 30, // Increase size for boldness
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}