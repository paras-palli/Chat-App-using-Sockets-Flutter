import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String txt;
  const ChatBubble({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(2),
      child: Text(
        txt,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
