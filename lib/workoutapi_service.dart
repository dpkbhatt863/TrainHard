import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatProvider2 with ChangeNotifier {
  String? _workoutPlan;
  String? get workoutPlan => _workoutPlan;

  // final String apiKey = const String.fromEnvironment('AIzaSyDhV5R81mWi2CAHemRLR9d2rTnOlgKuolI');
  final String apiKey = 'AIzaSyALBwoTpCChJXSGwIr4giAqsn38y2wBric';

  Future<void> generateWorkoutPlan(
    String fitnessGoal,
    String activityLevel,
    String bodyType,
    int age,
    double height,
    double weight,
  ) async {
    if (apiKey.isEmpty) {
      print("No API Key provided.");
      return;
    } else {
      print("API Key: $apiKey");
    }

    // Create the Gemini Generative Model instance
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    String prompt = '''
      Create a 7-day workout plan focused on progressive overload and muscle gain, tailored to the following individual details:
      Provide only and only the workout plan without any disclaimers or extra text or formatting:
      - Fitness Goal: $fitnessGoal
      - Activity Level: $activityLevel
      - Body Type: $bodyType
      - Age: $age
      - Height: $height cm
      - Weight: $weight kg

      Requirements:
      - The plan must progressively increase intensity, weights, or repetitions over the week.
      - Include a balanced split of workouts targeting major muscle groups: chest, back, shoulders, arms, legs, and core.
      - Specify warm-up exercises, main workout (strength-focused with details on sets, reps, and weights), and cool-down/stretching routines.
      - Suggest rest days or active recovery based on physical conditions and activity level.
      - Adapt exercises for the individual's physical attributes (e.g., age, weight, and body type) to ensure safety and effectiveness.
    ''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      _workoutPlan = response.text;
      notifyListeners();
    } catch (e) {
      print("Error generating workout plan: $e");
      _workoutPlan = "Failed to generate workout plan.";
      notifyListeners();
    }
  }
}
