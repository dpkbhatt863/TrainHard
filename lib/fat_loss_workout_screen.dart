import 'package:flutter/material.dart';

class FatLossWorkoutScreen extends StatelessWidget {
  final Color bloodRed = Color(0xFFB00000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDayCard('Monday - Full Body HIIT', [
            'Warm-up: 5 minutes light cardio',
            'Circuit (4 rounds, 40 seconds work, 20 seconds rest):',
            '- Burpees',
            '- Mountain Climbers',
            '- Jump Squats',
            '- Push-ups',
            'Cool-down: 5 minutes stretching',
          ]),
          _buildDayCard('Tuesday - Lower Body and Core', [
            'Squats: 3 sets of 12-15 reps',
            'Lunges: 3 sets of 10 reps per leg',
            'Glute Bridges: 3 sets of 15 reps',
            'Plank: 3 sets of 30-60 seconds',
            'Russian Twists: 3 sets of 20 reps',
            '20 minutes moderate-intensity cardio',
          ]),
          _buildDayCard('Wednesday - Cardio and Flexibility', [
            '30 minutes of jogging or cycling',
            '20 minutes of yoga or stretching',
          ]),
          _buildDayCard('Thursday - Upper Body and HIIT', [
            'Push-ups: 3 sets of 10-15 reps',
            'Dumbbell Rows: 3 sets of 12 reps per arm',
            'Shoulder Press: 3 sets of 12 reps',
            'Tricep Dips: 3 sets of 10-15 reps',
            'HIIT Finisher: 10 minutes alternating 30 seconds high-intensity, 30 seconds rest',
          ]),
          _buildDayCard('Friday - Full Body Strength', [
            'Deadlifts: 3 sets of 10-12 reps',
            'Chest Press: 3 sets of 12 reps',
            'Pull-ups or Lat Pulldowns: 3 sets of 8-10 reps',
            'Leg Press: 3 sets of 15 reps',
            'Plank to Push-up: 3 sets of 10 reps',
            '15 minutes of high-intensity cardio',
          ]),
          _buildDayCard('Saturday - Cardio and Core', [
            '45 minutes of moderate-intensity cardio (e.g., swimming, cycling, or brisk walking)',
            'Ab Circuit (3 rounds):',
            '- Crunches: 20 reps',
            '- Leg Raises: 15 reps',
            '- Side Planks: 30 seconds each side',
          ]),
          _buildDayCard('Sunday - Active Recovery', [
            'Light walk or yoga session',
            'Foam rolling and stretching',
            'Meal prep for the week',
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