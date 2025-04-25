import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message['isMe'] ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message['text']),
      ),
    );
  }
}
