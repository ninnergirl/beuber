import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final Function(Map<String, dynamic>) onSend;

  const InputField({super.key, required this.onSend});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final controller = TextEditingController();

  void sendMessage() {
    if (controller.text.trim().isNotEmpty) {
      widget.onSend({'text': controller.text, 'isMe': true});
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.emoji_emotions), onPressed: () {}),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Xabar yozing...'),
          ),
        ),
        IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
      ],
    );
  }
}
