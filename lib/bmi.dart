import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'nav.dart';
import 'dart:math';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  // Constants
  static const int BMI_TAB_INDEX = 2;

  // State variables
  int _selectedIndex = BMI_TAB_INDEX;
  String selectedGender = 'male';
  String result = '';

  // Controllers
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              _buildGenderSelection(),
              SizedBox(height: 24),
              _buildInputCard('Age', FaIcon(FontAwesomeIcons.cakeCandles), ageController),
              SizedBox(height: 16),
              _buildInputCard('Height (cm)', FaIcon(FontAwesomeIcons.rulerVertical), heightController),
              SizedBox(height: 16),
              _buildInputCard('Weight (kg)', FaIcon(FontAwesomeIcons.weightScale), weightController),
              SizedBox(height: 24),
              _buildCalculateButton(),
              SizedBox(height: 24),
              if (result.isNotEmpty) _buildBMIDial(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Expanded(child: _buildGenderButton('Male', FaIcon(FontAwesomeIcons.mars), 'male')),
        SizedBox(width: 16),
        Expanded(child: _buildGenderButton('Female', FaIcon(FontAwesomeIcons.venus), 'female')),
      ],
    );
  }

  Widget _buildGenderButton(String label, FaIcon icon, String gender) {
    bool isSelected = selectedGender == gender;
    return ElevatedButton.icon(
      onPressed: () => setState(() => selectedGender = gender),
      icon: icon,
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xffbb0a1e) : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildInputCard(String label, FaIcon icon, TextEditingController controller) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            icon,
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffbb0a1e)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _calculateBMI,
      child: Text(
        'Calculate BMI',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffbb0a1e),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildBMIDial() {
    double bmiValue = double.tryParse(result) ?? 0;
    Color dialColor = _getBMIColor(bmiValue);

    return Column(
      children: [
        Container(
          width: 250,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(250, 250),
                painter: BMIDialPainter(bmiValue: bmiValue, dialColor: dialColor),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: dialColor,
                    ),
                  ),
                  Text(
                    'BMI',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          _getBMICategory(bmiValue),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: dialColor,
          ),
        ),
      ],
    );
  }

  // Logic methods
  void _calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    if (height > 0 && weight > 0) {
      double finalResult = weight / (pow(height / 100, 2));
      setState(() => result = finalResult.toStringAsFixed(2));
    } else {
      setState(() => result = 'Invalid input');
    }
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/progress');
          break;
      }
    }
  }
}

class BMIDialPainter extends CustomPainter {
  final double bmiValue;
  final Color dialColor;

  BMIDialPainter({required this.bmiValue, required this.dialColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    _drawBackgroundCircle(canvas, center, radius);
    _drawBMIArc(canvas, center, radius);
    _drawTickMarks(canvas, center, radius);
    _drawNeedle(canvas, center, radius);
    _drawCenterCircle(canvas, center);
  }

  void _drawBackgroundCircle(Canvas canvas, Offset center, double radius) {
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    canvas.drawCircle(center, radius - 10, backgroundPaint);
  }

  void _drawBMIArc(Canvas canvas, Offset center, double radius) {
    final rect = Rect.fromCircle(center: center, radius: radius - 10);
    final gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
      stops: [0.0, 0.25, 0.5, 0.75],
    );

    final bmiPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (bmiValue / 40) * 2 * pi;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, bmiPaint);
  }

  void _drawTickMarks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = Colors.grey[600]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 40; i++) {
      final angle = i * (2 * pi / 40) - (pi / 2);
      final outerPoint = center + Offset(cos(angle) * (radius - 5), sin(angle) * (radius - 5));
      final innerPoint = center + Offset(cos(angle) * (radius - 20), sin(angle) * (radius - 20));
      canvas.drawLine(innerPoint, outerPoint, tickPaint);
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final needleAngle = (bmiValue / 40) * 2 * pi - (pi / 2);
    final needlePoint = center + Offset(cos(needleAngle) * (radius - 30), sin(needleAngle) * (radius - 30));
    canvas.drawLine(center, needlePoint, needlePaint);
  }

  void _drawCenterCircle(Canvas canvas, Offset center) {
    final centerCirclePaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}