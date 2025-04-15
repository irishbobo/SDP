import 'package:flutter/material.dart';
import 'other_pages.dart'; // Ensure this import is correct
import 'account_info_page.dart'; // Ensure this import is correct
import 'chat_bubble.dart'; // This should be your FloatingChatBubble

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const PageOne(),
    const PageFour(),
    const PageTwo(),
    const PageThree(),
    const PageFive(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/Fridge_Maid_Logo.gif',
                height: 40.0,
              ),
              const SizedBox(width: 8),
              const Text(
                'Fridge Maid',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
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
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 10,
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
              icon: Icon(Icons.fact_check),
              label: 'Calories',
            ),
          ],
        ),
      ),
    );
  }
}
