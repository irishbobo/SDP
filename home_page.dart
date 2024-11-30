import 'package:flutter/material.dart';
import 'other_pages.dart'; // Ensure this import is correct
import 'account_info_page.dart'; // Ensure this import is correct

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  int _selectedIndex = 2;

  // List of pages
  final List<Widget> _pages = [
    const PageOne(), // Fridge
    const PageFive(), // Recipes
    const PageTwo(), // Home
    const PageThree(), // Schedule
    const PageFour(), // Settings
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
        centerTitle: true, // Center the title
        title: const Text('Fridge Maid'), // Set the title to "Fridge Maid"
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
            icon: Icon(Icons.list),
            label: 'Recipes',
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
        ],
      ),
    );
  }
}
