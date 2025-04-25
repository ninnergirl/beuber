import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatPage extends StatefulWidget {
  final String userID;
  final String roomID;

  const ChatPage({super.key, required this.userID, required this.roomID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  bool showEmoji = false;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.onConnect((_) {
      print("Socketga ulandi");
      socket.emit('join_room', widget.roomID);
    });

    socket.on('receive_message', (data) {
      setState(() {
        messages.add(data);
      });
    });

    socket.onDisconnect((_) => print("Ajraldi"));
  }

  void sendTextMessage() {
    if (_messageController.text.isNotEmpty) {
      final msg = {
        'user': widget.userID,
        'room': widget.roomID,
        'message': _messageController.text,
        'type': 'text',
      };
      socket.emit('send_message', msg);
      setState(() {
        messages.add(msg);
        _messageController.clear();
      });
    }
  }

  Future<void> sendImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final msg = {
        'user': widget.userID,
        'room': widget.roomID,
        'image': file.path,
        'type': 'image',
      };
      socket.emit('send_message', msg);
      setState(() {
        messages.add(msg);
      });
    }
  }

  Future<void> sendFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      final msg = {
        'user': widget.userID,
        'room': widget.roomID,
        'file': file.path,
        'type': 'file',
      };
      socket.emit('send_message', msg);
      setState(() {
        messages.add(msg);
      });
    }
  }

  Widget buildEmojiPicker() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        _messageController.text += emoji.emoji;
      },
      config: const Config(columns: 7, emojiSizeMax: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                if (msg['type'] == 'image') {
                  return Image.file(File(msg['image']));
                } else if (msg['type'] == 'file') {
                  return ListTile(
                    title: Text("📎 File: ${msg['file'].split('/').last}"),
                    onTap: () {
                      // Optional: Add file open/download logic here
                    },
                  );
                } else {
                  return ListTile(title: Text(msg['message']));
                }
              },
            ),
          ),
          if (showEmoji) SizedBox(height: 250, child: buildEmojiPicker()),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.emoji_emotions),
                onPressed: () => setState(() => showEmoji = !showEmoji),
              ),
              IconButton(icon: const Icon(Icons.image), onPressed: sendImage),
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: sendFile,
              ),
              Expanded(child: TextField(controller: _messageController)),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendTextMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
