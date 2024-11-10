import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/welcome/welcome_screen.dart';

class MedicalFieldsScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _getUserName() {
    User? user = _auth.currentUser;
    return user?.displayName ?? 'USER';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[400]!, Colors.teal[800]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      },
                      child: const Text('LOG OUT'),
                    ),
                  ),
                  Text(
                    'Welcome, ${_getUserName()}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Choose Your Field',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FieldButtonRow(
                    buttons: [
                      FieldButton(
                        label: 'Diabetic Doctor',
                        subtitle: 'DAVID',
                      ),
                      FieldButton(
                        label: 'Psychologist',
                        subtitle: 'BOB',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FieldButtonRow(
                    buttons: [
                      FieldButton(
                        label: 'Pediatrician',
                        subtitle: 'ness',
                      ),
                      FieldButton(
                        label: 'General Practitioner',
                        subtitle: 'nourou',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.teal[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Handle "For Animals" action
                    },
                    child: const Text(
                      'FOR ANIMALS',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: [
            // Settings button

            Positioned(
              left: 8,
              top: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    // Navigate to Settings Screen
                  },
                  backgroundColor: Colors.teal[300],
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // About Us button
            Positioned(
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle "About Us" action
                  },
                  backgroundColor: Colors.teal[300],
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class FieldButtonRow extends StatelessWidget {
  final List<FieldButton> buttons;

  const FieldButtonRow({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: buttons,
    );
  }
}

class FieldButton extends StatelessWidget {
  final String label;
  final String subtitle;

  const FieldButton({
    Key? key,
    required this.label,
    this.subtitle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.teal[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
