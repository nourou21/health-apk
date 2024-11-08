import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/SLIDERS/firstslide.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(); // Repeats the animation continuously
    _navigateHome();
  }

  _navigateHome() async {
    // Wait for 5 seconds before navigating to the next screen
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => fisrtsld(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Static Logo in the center
            Image.asset(
              "assets/logo.png", // Your PNG logo
              width: 100, // Adjust size as needed
              height: 100, // Adjust size as needed
            ),
            SizedBox(height: 20),

            // Rotating Symbol below the logo
            RotationTransition(
              turns: _controller,
              child: Icon(
                Icons
                    .autorenew, // You can replace this with any other icon or symbol
                color: Color(0xFF5CA6B0),
                size: 40,
              ),
            ),
            SizedBox(height: 20),

            // "QcodeR" Text with right-to-left animation
            Text(
              "DoCtor Chat",
              style: GoogleFonts.inter(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5CA6B0),
              ),
            ).animate().slideX(begin: 1, end: 0, duration: 1.seconds),
          ],
        ),
      ),
    );
  }
}
