import 'package:flutter/material.dart';

class MuscleGainWorkoutScreen extends StatelessWidget {
  final Color bloodRed = Color(0xFFB00000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDayCard('Monday - Chest and Triceps', [
            'Bench Press: 4 sets of 8-10 reps',
            'Incline Dumbbell Press: 3 sets of 10-12 reps',
            'Chest Flyes: 3 sets of 12-15 reps',
            'Tricep Pushdowns: 3 sets of 10-12 reps',
            'Overhead Tricep Extensions: 3 sets of 10-12 reps',
          ]),
          _buildDayCard('Tuesday - Back and Biceps', [
            'Deadlifts: 4 sets of 6-8 reps',
            'Pull-ups or Lat Pulldowns: 3 sets of 8-10 reps',
            'Barbell Rows: 3 sets of 8-10 reps',
            'Barbell Curls: 3 sets of 10-12 reps',
            'Hammer Curls: 3 sets of 10-12 reps',
          ]),
          _buildDayCard('Wednesday - Rest Day', [
            'Active recovery or light cardio',
            'Stretching and mobility work',
          ]),
          _buildDayCard('Thursday - Shoulders and Abs', [
            'Military Press: 4 sets of 8-10 reps',
            'Lateral Raises: 3 sets of 12-15 reps',
            'Front Raises: 3 sets of 12-15 reps',
            'Planks: 3 sets of 30-60 seconds',
            'Russian Twists: 3 sets of 20 reps',
          ]),
          _buildDayCard('Friday - Legs', [
            'Squats: 4 sets of 8-10 reps',
            'Leg Press: 3 sets of 10-12 reps',
            'Romanian Deadlifts: 3 sets of 10-12 reps',
            'Leg Extensions: 3 sets of 12-15 reps',
            'Calf Raises: 4 sets of 15-20 reps',
          ]),
          _buildDayCard('Saturday - Full Body', [
            'Push-ups: 3 sets to failure',
            'Pull-ups: 3 sets to failure',
            'Dips: 3 sets to failure',
            'Lunges: 3 sets of 12 reps per leg',
            'Plank to Push-up: 3 sets of 10 reps',
          ]),
          _buildDayCard('Sunday - Rest Day', [
            'Complete rest or light activity',
            'Focus on recovery and meal prep for the week',
          ]),
        ],
      ),
    );
  }

  Widget _buildDayCard(String day, List<String> exercises) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...exercises.map((exercise) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('• $exercise'),
            )),
          ],
        ),
      ),
    );
  }
}