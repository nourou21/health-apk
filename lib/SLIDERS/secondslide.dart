import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class secondslid extends StatefulWidget {
  const secondslid({super.key});

  @override
  State<secondslid> createState() => _secondslidState();
}

class _secondslidState extends State<secondslid> {
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
            // Full-screen background image (slider2)
            Positioned.fill(
              child: Image.asset(
                'assets/slider2.jpeg',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
            // 'secondslide.png' placed at the middle-bottom of the screen, now even smaller
            Positioned(
              bottom: 20, // Adjust the bottom padding for better position
              left: screenWidth / 2 -
                  82, // Center it horizontally by subtracting half the width of the image
              child: Image.asset(
                'assets/secondslide.png',
                height: 40, // Even smaller height for the image
                width: 150, // Smaller width of the image
                fit: BoxFit.cover, // Keep it scaled properly
              ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
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
            // Next button to navigate to the Welcome screen at bottom-right
            Positioned(
              bottom: 10, // Positioning button above the image
              right: 7, // Placing button at the bottom-right corner
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
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
                    Text('Next'), // Text displayed next to the icon
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.grey.shade800, // Text color on the button
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
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
