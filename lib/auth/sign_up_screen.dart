import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _userName, _email, _password;

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
            fit: BoxFit.cover,
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    _buildSignUpForm(),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: Text("Register"),
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

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldLabel(text: "Username"),
          TextFormField(
            decoration: InputDecoration(hintText: "Enter username"),
            validator: RequiredValidator(errorText: "Username is required"),
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldLabel(text: "Email"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter email"),
            validator: EmailValidator(errorText: "Please enter a valid email"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldLabel(text: "Password"),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Enter password"),
            validator: MinLengthValidator(6,
                errorText: "Minimum 6 characters required"),
            onSaved: (password) => _password = password!,
          ),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        await userCredential.user!.sendEmailVerification();
        await userCredential.user!.updateDisplayName(_userName);

        // Show success SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-up successful! Please verify your email.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed: ${e.message}')),
        );
      }
    }
  }
}

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
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
