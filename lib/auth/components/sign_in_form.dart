import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/sign_up_screen.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          ),
                          child: Text("Sign Up!",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SignInForm(
                      formKey: _formKey,
                      onEmailSaved: (email) => _email = email,
                      onPasswordSaved: (password) => _password = password,
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: _email.trim(),
                                password: _password.trim(),
                              );
                              print(
                                  "Sign-in successful: ${userCredential.user?.email}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Sign-in successful!')));
                              // Navigate to the next screen here (e.g., home screen)
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                String errorMessage =
                                    _getFirebaseAuthErrorMessage(e);
                                print("Error signing in: $errorMessage");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Sign-in failed: $errorMessage')));
                              } else {
                                print("Unknown error: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Sign-in failed: Unknown error')));
                              }
                            }
                          }
                        },  
                        child: Text("Sign In"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to get error message from FirebaseAuth exceptions
  String _getFirebaseAuthErrorMessage(Exception e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'invalid-email':
          return 'The email address is not valid.';
        default:
          return 'An unknown error occurred.';
      }
    }
    return 'An unknown error occurred.';
  }
}

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
    required this.formKey,
    required this.onEmailSaved,
    required this.onPasswordSaved,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final Function(String) onEmailSaved;
  final Function(String) onPasswordSaved;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Email"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => onEmailSaved(email!),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: "******"),
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'Password cannot be empty!';
              }
              return null; // If valid, return null
            },
            onSaved: (password) => onPasswordSaved(password!),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
