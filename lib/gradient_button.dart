import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double horizontalPadding;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 30,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [const Color(0xff000000), const Color(0xff2C3E50)]
                : [const Color(0xff414141), const Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white70, width: 2),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 5,
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-5, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: 15),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}