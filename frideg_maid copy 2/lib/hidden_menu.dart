import 'package:flutter/material.dart';

class HiddenMenu extends StatefulWidget {
  final Widget child;

  HiddenMenu({required this.child});

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  bool _isMenuVisible = false;

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Swipe right or hover to access the menu"),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search"),
        content: TextField(
          decoration: InputDecoration(hintText: "Enter search query"),
          onSubmitted: (query) {
            print("Searching for: $query");
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showChatbotPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("AI Chatbot"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Chatbot interaction goes here."),
            TextField(
              decoration: InputDecoration(hintText: "Type a message..."),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleMenu,
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta! > 10) {
                // Swipe right to open menu
                setState(() => _isMenuVisible = true);
              } else if (details.primaryDelta! < -10) {
                // Swipe left to close menu
                setState(() => _isMenuVisible = false);
              }
            },
            child: widget.child,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _isMenuVisible ? 0 : -200,
            top: 0,
            bottom: 0,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isMenuVisible = true),
              onExit: (_) => setState(() => _isMenuVisible = false),
              child: Container(
                width: 200,
                color: Colors.grey.shade200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, size: 40), // Increased size
                      onPressed: _showSearchDialog,
                    ),
                    IconButton(
                      icon: Icon(Icons.android, size: 40), // Increased size
                      onPressed: _showChatbotPopup,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Small Menu Tab (Visible when menu is hidden)
          /*Positioned(
            left: _isMenuVisible ? 200 : 0, // Moves with menu
            top: MediaQuery.of(context).size.height / 2 - 40,
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                width: 30,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                ),
                child: Icon(Icons.menu, color: Colors.white, size: 30),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
