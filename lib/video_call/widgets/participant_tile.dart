import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ParticipantTile extends StatelessWidget {
  final ZegoUIKitUser user;

  const ParticipantTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 30, child: Text(user.name.characters.first)),
        const SizedBox(height: 8),
        Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
