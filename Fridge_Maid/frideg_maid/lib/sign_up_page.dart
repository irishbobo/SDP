import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers to capture user input
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController birthdayController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    // Function to show the date picker
    Future<void> selectDate(BuildContext context) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900), // Minimum date allowed
        lastDate: DateTime.now(), // Maximum date allowed
      );

      // If the user picked a date, update the text field
      if (selectedDate != null) {
        birthdayController.text =
            "${selectedDate.toLocal()}".split(' ')[0]; // Format the date
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First and Last Name input in the same Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0), // Spacing
            // Birthday input field with DatePicker
            TextField(
              controller: birthdayController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Birthday',
                hintText: 'Select your birthday',
              ),
              readOnly: true, // Disable manual text input
              onTap: () => selectDate(context), // Show the date picker on tap
            ),
            const SizedBox(height: 16.0), // Spacing
            // Email input field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress, // Email keyboard
            ),
            const SizedBox(height: 16.0),
            // Continue button
            ElevatedButton(
              onPressed: () {
                // Navigate to the second sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage2()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage2 extends StatelessWidget {
  const SignUpPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Account creation logic goes here
                // After successful account creation, navigate to the home page
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
