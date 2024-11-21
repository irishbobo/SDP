import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'home_page.dart';
import 'account_info_page.dart';
import 'add_food_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const MyHomePage(),
        '/account': (context) => const AccountInfoPage(),
        '/add_food': (context) => const AddFoodPage(),
      },
    );
  }
}
