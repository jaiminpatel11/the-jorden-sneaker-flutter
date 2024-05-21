import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_jorden_sneakers/screens/home_screen.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({Key? key}) : super(key: key);

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> with SingleTickerProviderStateMixin {
  late AnimationController _secondAnimationController;
  bool _firstAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _secondAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: _firstAnimationCompleted
              ? _buildSecondAnimation()
              : _buildFirstAnimation(),
        ),
      ),
    );
  }

  Widget _buildFirstAnimation() {
    return Lottie.asset(
      'assets/Lottie/Animation - 1712530474465.json',
      width: 600,
      height: 600,
      fit: BoxFit.contain,
      onLoaded: (composition) {
        // Add a delay here if needed
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _firstAnimationCompleted = true;
          });
          _secondAnimationController.forward();
        });
      },
    );
  }

  Widget _buildSecondAnimation() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/Lottie/celebration.json',
          width: 600,
          height: 600,
          fit: BoxFit.contain,
          controller: _secondAnimationController,
          onLoaded: (composition) {
            // Play animation once loaded
            _secondAnimationController.duration = composition.duration;
            _secondAnimationController.forward();
          },
        ),
        SizedBox(height: 20),
        Text(
          'Thank you for shopping!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF674AEF),
          ),
        ),
      ],
    );
  }
}
