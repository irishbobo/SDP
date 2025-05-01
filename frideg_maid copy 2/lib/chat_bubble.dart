import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final Widget child;

  const ChatBubble({super.key, required this.child});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Offset _position = const Offset(20, 100); // Initial bubble position

  void _showChatbotPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("AI Chatbot"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Chatbot interaction goes here."),
            TextField(
              decoration: InputDecoration(hintText: "Type a message..."),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
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
          widget.child,
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: _buildBubble(),
              childWhenDragging: const SizedBox(),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
              child: GestureDetector(
                onTap: _showChatbotPopup,
                child: _buildBubble(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}
