import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(FontAwesomeIcons.home, 'Home', 0),
          _buildNavItem(FontAwesomeIcons.barsProgress, 'Progress', 1),
          _buildNavItem(FontAwesomeIcons.plus, 'BMI', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, color: isSelected ? Colors.red : Colors.white),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.white,
                  fontSize: 12,
                  fontFamily: 'Manteka',
                ),
              ),
            ],
          ),
          if (isSelected)
            Positioned(
              top: 0,
              child: Container(
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}