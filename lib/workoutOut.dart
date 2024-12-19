import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'workoutapi_service.dart';

class WorkoutOutputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutPlan = Provider.of<ChatProvider2>(context).workoutPlan;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Workout Plan'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: workoutPlan == null
              ? Center(child: CircularProgressIndicator(color: Colors.white,))
              : Text(
                  workoutPlan,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
