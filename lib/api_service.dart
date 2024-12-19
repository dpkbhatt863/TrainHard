import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatProvider with ChangeNotifier {
  String? _dietPlan;
  String? get dietPlan => _dietPlan;

  // final String apiKey = const String.fromEnvironment('AIzaSyDhV5R81mWi2CAHemRLR9d2rTnOlgKuolI');
  final String apiKey = 'AIzaSyDhV5R81mWi2CAHemRLR9d2rTnOlgKuolI';
  
  Future<void> generateDietPlan(String dietGoal, String activityLevel, String mealPreference, int mealsPerDay, int waterIntake, String? dietaryRestrictions) async {
    if (apiKey.isEmpty) {
  print("No API Key provided.");
  return;
} else {
  print("API Key: $apiKey");
}

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    String prompt = '''
      Create a 7-day(name them as sunday monday tuesday wednesday friday saturday) diet plan for a person with the following details:
      and give only and only the INDIAN diet plan without any disclaimor without any kind of extra text of formatting
      - Diet Goal: $dietGoal
      - Activity Level: $activityLevel
      - Meal Preference: $mealPreference
      - Meals Per Day: $mealsPerDay
      - Water Intake: $waterIntake ml
      - Dietary Restrictions: ${dietaryRestrictions ?? "None"}
      Provide the diet plan as day-wise meal suggestions with breakfast, lunch, dinner, and snacks.
    ''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      _dietPlan = response.text;
      notifyListeners();
    } catch (e) {
      print("Error generating diet plan: $e");
      _dietPlan = "Failed to generate diet plan.";
      notifyListeners();
    }
  }
}
