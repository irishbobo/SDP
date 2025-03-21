import 'package:flutter/material.dart';
import 'other_pages.dart'; // Ensure this import is correct
import 'account_info_page.dart'; // Ensure this import is correct

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
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize
              .min, // To ensure the row takes only as much space as needed
          children: [
            Image.asset(
              'assets/images/Fridge_Maid_Logo.gif', // Replace with your logo path
              height: 40.0, // Size the logo
            ),
            const SizedBox(width: 8), // Add some space between the logo and the title
            const Text(
              'Fridge Maid', // Set the title to "Fridge Maid"
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make the title bold
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile icon
            onPressed: () {
              // Navigate to the AccountInfoPage when clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountInfoPage(),
                ),
              );
            },
          ),
        ],
      ),
     
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
