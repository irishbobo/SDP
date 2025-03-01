import 'package:flutter/material.dart';
import 'other_pages.dart'; // Ensure this import is correct
// Ensure this import is correct

class CalorieTrackerHome extends StatefulWidget {
  const CalorieTrackerHome({super.key});

  @override
  _CalorieTrackerHomeState createState() => _CalorieTrackerHomeState();
}

class _CalorieTrackerHomeState extends State<CalorieTrackerHome> {
  int _selectedIndex = 5;

  // List of pages
  final List<Widget> _pages = [
    const PageOne(), // Fridge
    const PageFive(), // Recipes
    const PageTwo(), // Home
    const PageThree(), // Schedule
    const PageFour(), // Settings
    const PageSix(), // Calorie Tracker Home
  ];

  // Function to handle tab switch
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Color when selected
        unselectedItemColor: Colors.grey, // Color when not selected
        backgroundColor: Colors.white, // Background color of the navbar
        elevation: 10, // Shadow for the navbar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Fridge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipe Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Calories',
          ),
        ],
      ),
    );
  }
}
