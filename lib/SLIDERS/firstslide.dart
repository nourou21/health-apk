import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/SLIDERS/secondslide.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome

class fisrtsld extends StatefulWidget {
  const fisrtsld({super.key});

  @override
  State<fisrtsld> createState() => _fisrtsldState();
}

class _fisrtsldState extends State<fisrtsld> {
  @override
  void initState() {
    super.initState();

    // Hides the system status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    // Show the system UI elements when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the full screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 166, 176, 1),
      body: SafeArea(
        child: Stack(
          children: [
            // Slider1 Image that takes full screen height and width
            Positioned.fill(
              child: Image.asset(
                'assets/slider1.jpeg',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
            // 'firstslide.png' placed at the middle-bottom of the screen, now smaller
            Positioned(
              bottom: 20, // Adjust the bottom padding for better position
              left: screenWidth / 2 -
                  80, // Center it horizontally by subtracting half the width of the image
              child: Image.asset(
                'assets/firstslide.png',
                height: 40, // Further reduced height
                width: 150, // Further reduced width
                fit: BoxFit.cover, // Keep it scaled properly
              ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
            ),
            // Arrow button to navigate to the second slide at bottom-right
            Positioned(
              bottom: 10, // Positioning button above the image
              right: 7, // Placing button at the bottom-right corner
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_right,
                  size: 50,
                  color: Colors.grey.shade900,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const secondslid(),
                    ),
                  );
                },
                color: Colors.grey,
              )
                  .animate()
                  .fade(duration: 500.ms)
                  .scale(delay: 500.ms)
                  .fade(delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
