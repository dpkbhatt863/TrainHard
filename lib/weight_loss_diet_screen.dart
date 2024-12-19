import 'package:flutter/material.dart';

class WeightLossDietScreen extends StatelessWidget {
  final Color bloodRed = Color(0xFFB00000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(
    padding: EdgeInsets.all(16),
    children: [
    _buildDayCard('Monday', [
    'Breakfast: Veggie omelet with whole grain toast',
    'Snack: Apple slices with almond butter',
    'Lunch: Grilled chicken salad with mixed greens and light dressing',
    'Snack: Carrot sticks with hummus',
    'Dinner: Baked salmon with roasted Brussels sprouts',
    ]),
    _buildDayCard('Tuesday', [
    'Breakfast: Greek yogurt with berries and a sprinkle of granola',
    'Snack: Handful of unsalted mixed nuts',
    'Lunch: Turkey and avocado wrap with a side salad',
    'Snack: Celery sticks with peanut butter',
    'Dinner: Lean beef stir-fry with mixed vegetables',
    ]),
    _buildDayCard('Wednesday', [
    'Breakfast: Overnight oats with chia seeds and sliced banana',
    'Snack: Hard-boiled egg and cherry tomatoes',
    'Lunch: Tuna salad on a bed of mixed greens',
    'Snack: Cucumber slices with tzatziki dip',
    'Dinner: Grilled chicken breast with quinoa and steamed broccoli',
    ]),
    _buildDayCard('Thursday', [
    'Breakfast: Whole grain toast with mashed avocado and poached egg',
    'Snack: Small handful of almonds and an orange',
    'Lunch: Lentil soup with a side of mixed green salad',
    'Snack: Greek yogurt with a sprinkle of cinnamon',
    'Dinner: Baked cod with roasted sweet potato and asparagus',
    ]),
    _buildDayCard('Friday', [
    'Breakfast: Smoothie bowl (spinach, banana, protein powder, almond milk)',
    'Snack: Rice cake with almond butter',
    'Lunch: Grilled vegetable and chicken skewers with tzatziki',
    'Snack: Sliced bell peppers with guacamole',
    'Dinner: Turkey meatballs with zucchini noodles and marinara sauce',
    ]),
    _buildDayCard('Saturday', [
    'Breakfast: Scrambled tofu with spinach and whole grain toast',
    'Snack: Small apple and a few walnuts',
      'Lunch: Grilled chicken and quinoa salad with mixed greens',
      'Snack: Mixed berries with a dollop of Greek yogurt',
      'Dinner: Baked chicken thighs with roasted vegetables and brown rice',
    ]),
      _buildDayCard('Sunday', [
        'Breakfast: Pancakes made with oats, topped with fresh fruit',
        'Snack: A handful of mixed nuts and an orange',
        'Lunch: Grilled shrimp with a quinoa and spinach salad',
        'Snack: Sliced cucumbers with hummus',
        'Dinner: Baked chicken with sweet potatoes and steamed broccoli',
      ]),
    ],
    ),
    );
  }

  Widget _buildDayCard(String day, List<String> meals) {
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
            ...meals.map((meal) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('• $meal'),
            )),
          ],
        ),
      ),
    );
  }
}