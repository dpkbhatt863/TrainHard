import 'dart:async';
import 'package:flutter/material.dart';
//import 'home.dart';
//import 'drawer.dart';
//import 'logIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;
  late Animation<Offset> _slideAnimationLeft;
  late Animation<Offset> _slideAnimationRight;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimationAndNavigation();
  }

  void _setupAnimations() {
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.easeInOut))
    );

    _slideAnimationLeft = Tween<Offset>(begin: Offset.zero, end: Offset(-2.0, 0)).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.easeInOut))
    );

    _slideAnimationRight = Tween<Offset>(begin: Offset.zero, end: Offset(2.0, 0)).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.easeInOut))
    );
  }

  void _startAnimationAndNavigation() {
    _controller.forward();
     Timer(Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacementNamed('/main');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Color(0xFF1A1A1A)],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildAnimatedWord('T', 'RAIN', 350, 130, _slideAnimationLeft),
            _buildAnimatedWord('H', 'ARD', 440, 180, _slideAnimationRight),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWord(String firstLetter, String restOfWord, double top, double left, Animation<Offset> slideAnimation) {
    return Positioned(
      top: top,
      left: left,
      child: SlideTransition(
        position: slideAnimation,
        child: _buildAnimatedText(firstLetter, restOfWord),
      ),
    );
  }

  Widget _buildAnimatedText(String firstLetter, String restOfWord) {
    return Row(
      children: [
        Text(
          firstLetter,
          style: TextStyle(
              color: Color(0xffbb0a1e),
              fontFamily: 'Splash_font',
              fontSize: 70,
              fontWeight: FontWeight.w800
          ),
        ),
        ClipRect(
          child: AnimatedBuilder(
            animation: _revealAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                widthFactor: _revealAnimation.value,
                child: Container(
                  width: 100,
                  child: Text(
                    restOfWord,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Splash_font'
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}