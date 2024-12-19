import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'workoutOut.dart';
import 'workoutapi_service.dart';


class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String? _goal;
  String? _gender;
  String? _bodyType;
  int? _age;
  double? _height;
  double? _weight;

  final Color bloodRed = Color(0xFFB00000);

  final List<Map<String, dynamic>> _goals = [
    {'icon': Icons.fitness_center, 'label': 'Lose Weight'},
    {'icon': Icons.directions_run, 'label': 'Gain Muscle'},
    {'icon': Icons.favorite, 'label': 'Maintain Fitness'},
  ];

  final List<Map<String, dynamic>> _genders = [
    {'icon': Icons.male, 'label': 'Male'},
    {'icon': Icons.female, 'label': 'Female'},
    {'icon': Icons.transgender, 'label': 'Other'},
  ];

  final List<Map<String, dynamic>> _bodyTypes = [
    {'icon': Icons.child_care, 'label': 'Ectomorph'},
    {'icon': Icons.person, 'label': 'Mesomorph'},
    {'icon': Icons.sports_handball, 'label': 'Endomorph'},
  ];

  void _handleSubmit() {
    if (_goal == null || _gender == null || _bodyType == null || _age == null || _height == null || _weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all selections')),
      );
      return;
    }

    final chatProvider = Provider.of<ChatProvider2>(context, listen: false);
    chatProvider.generateWorkoutPlan(
      _goal!,
      "Intermediate", // Example activity level
      _bodyType!,
      _age!,
      _height!,
      _weight!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutOutputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 40, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Fitness Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('What is your fitness goal?'),
              _buildRadioGroup(_goals, (value) => setState(() => _goal = value)),
              _buildSectionTitle('What is your gender?'),
              _buildRadioGroup(_genders, (value) => setState(() => _gender = value)),
              _buildSectionTitle('What is your body type?'),
              _buildRadioGroup(_bodyTypes, (value) => setState(() => _bodyType = value)),
              _buildInputField('Age', (value) => setState(() => _age = int.tryParse(value))),
              _buildInputField('Height (cm)', (value) => setState(() => _height = double.tryParse(value))),
              _buildInputField('Weight (kg)', (value) => setState(() => _weight = double.tryParse(value))),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  child: Text(
                    'Generate Workout Plan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bloodRed,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _handleSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildRadioGroup(List<Map<String, dynamic>> options, Function(String) onChanged) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        bool isSelected = _goal == option['label'] || _gender == option['label'] || _bodyType == option['label'];
        return GestureDetector(
          onTap: () => onChanged(option['label']),
          child: Container(
            width: (MediaQuery.of(context).size.width - 52) / 3,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? bloodRed : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  option['icon'],
                  size: 24,
                  color: isSelected ? Colors.white : bloodRed,
                ),
                SizedBox(height: 8),
                Text(
                  option['label'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : bloodRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInputField(String label, Function(String) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: bloodRed),
              cursorColor: bloodRed,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: bloodRed, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
