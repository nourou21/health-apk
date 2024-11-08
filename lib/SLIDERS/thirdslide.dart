import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_application_1/welcome/welcome_screen.dart';

import 'package:flutter/services.dart'; // Import for SystemChrome

class thirdslide extends StatefulWidget {
  const thirdslide({super.key});

  @override
  State<thirdslide> createState() => _thirdslideState();
}

class _thirdslideState extends State<thirdslide> {
  @override
  void initState() {
    super.initState();
    // Hide system status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    // Restore system UI when leaving the screen
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
            // Full-screen background image (slider3.jpeg)
            Positioned.fill(
              child: Image.asset(
                'assets/slider3.jpeg', // Background image for this slide
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
            // 'thirdslide.png' placed at the middle-bottom of the screen
            Positioned(
              bottom: 70, // Adjust the bottom padding for better position
              left: screenWidth / 2 -
                  82, // Center it horizontally by subtracting half the width of the image
              child: Image.asset(
                'assets/thirdslide.png',
                height: 40, // Adjust the height to fit better in the layout
                width: 150, // Adjust the width
                fit: BoxFit.cover, // Keep it scaled properly
              ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
            ),
            // Text at the top part of the screen
            Positioned(
              top: 150, // Adjust the top padding for better positioning
              left: 50, // Positioning from the left side
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            // Arrow button to navigate to the previous slide at bottom-left
            Positioned(
              bottom: 10, // Positioning button above the image
              left: 7, // Placing button at the bottom-left corner
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_left,
                  size: 50,
                  color: Colors.grey.shade900,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Navigate back to the previous screen
                },
                color: Colors.grey,
              )
                  .animate()
                  .fade(duration: 500.ms)
                  .scale(delay: 500.ms)
                  .fade(delay: 500.ms),
            ),
            // Next button to navigate to the second slide (or any other screen)
            Positioned(
              bottom: 10, // Positioning button above the image
              right: 7, // Placing button at the bottom-right corner
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const WelcomeScreen(), // Adjust the next screen
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                    ), // Icon (in this case, a forward arrow)
                    SizedBox(
                        width: 2), // Horizontal spacing between icon and text
                    Text('Let\'s start'), // Text displayed next to the icon
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.grey.shade800, // Text color on the button
                  padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10), // Padding inside the button
                  textStyle:
                      TextStyle(fontSize: 18), // Text style of the button text
                ),
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
