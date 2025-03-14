// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

///boop
///
/// Root widget of the app, setting up routes and the initial home.
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Flow',
      theme: ThemeData(primarySwatch: Colors.blue),
      // We define named routes so it's easy to navigate between pages.
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
      },
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

///
/// The HomeScreen displays two large buttons:
/// 1) "Log In"
/// 2) "Sign Up"
/// Tapping these buttons navigates to the respective pages.
///
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Simple top app bar with a title.
      appBar: AppBar(
        title: Text('User Registration Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "Log In" button.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 16),
            // "Sign Up" button.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.routeName);
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// The actual authentication logic would go in the `handleLogin` method.
///
class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers to capture user input from text fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free resources.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Placeholder login logic
  /// Authentication API or database function here and handle success/failure.
  void handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    // TODO: Implement actual login logic. For testing:
    print('Attempting to log in with email: $email, password: $password');
    // For now, just pop back or show a success message...
    Navigator.pop(context); // Return to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password TextField (obscured)
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // Log In button
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for the string-based fields:
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _fitnessGoalController = TextEditingController();

  // For integer fields:
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // For sets, comma-separated strings,
  // then parse into sets when we "sign up."
  final TextEditingController _dietaryPreferencesController =
      TextEditingController();
  final TextEditingController _allergensController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers.
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _dobController.dispose();
    _sexController.dispose();
    _fitnessGoalController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _dietaryPreferencesController.dispose();
    _allergensController.dispose();
    super.dispose();
  }

  /// vvvvvvv  LOOK   AT   ME  vvvvvv !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  /// Placeholder sign-up logic.
  void handleSignUp() async {
    final String apiUrl =
        "https://0l9zfua2q4.execute-api.us-east-1.amazonaws.com/default/CreateUserLambda"; // This is our URL
    // Collect user input
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final dob = _dobController.text.trim();
    final sex = _sexController.text.trim();
    final fitnessGoal = _fitnessGoalController.text.trim();

    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final weight = int.tryParse(_weightController.text.trim()) ?? 0;
    final height = int.tryParse(_heightController.text.trim()) ?? 0;

    final dietaryPreferences = _dietaryPreferencesController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final allergens = _allergensController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Create JSON body
    final userData = jsonEncode({
      "name": name,
      "email": email,
      "phone_number": phone,
      "date_of_birth": dob,
      "age": age,
      "weight": weight,
      "height": height,
      "sex": sex,
      "fitness_goal": fitnessGoal,
      "dietary_preferences": dietaryPreferences,
      "allergens": allergens
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: userData,
      );

      if (response.statusCode == 200) {
        print("User Registered: ${jsonDecode(response.body)}");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration Successful!")));
      } else {
        print("Error: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Failed! ${response.body}")));
      }
    } catch (e) {
      print("Request failed: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // String fields
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            // Int fields
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            // More strings
            TextField(
              controller: _sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            TextField(
              controller: _fitnessGoalController,
              decoration: InputDecoration(
                  labelText: 'Fitness Goal (Lose Weight, Bulk, etc.)'),
            ),
            // Sets (comma-separated)
            TextField(
              controller: _dietaryPreferencesController,
              decoration: InputDecoration(
                  labelText: 'Dietary Preferences (comma-separated)'),
            ),
            TextField(
              controller: _allergensController,
              decoration:
                  InputDecoration(labelText: 'Allergens (comma-separated)'),
            ),
            SizedBox(height: 20),
            // Sign Up button
            ElevatedButton(
              onPressed: handleSignUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
