import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  // Log out method to pop all screens and navigate to the sign-in page
  void _logOut(BuildContext context) {
    Navigator.popUntil(
        context,
        (route) => route
            .isFirst); // This clears the stack and goes to the first route (sign-in page)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Username: John Doe',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: johndoe@example.com',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logOut(context), // Call the log out method
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
