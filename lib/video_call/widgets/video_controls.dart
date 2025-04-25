import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoControls extends StatelessWidget {
  const VideoControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ZegoToggleMicrophoneButton(
          iconSize: const Size(30, 30),
          buttonSize: const Size(50, 50),
        ),
        const SizedBox(width: 10),
        ZegoToggleCameraButton(
          iconSize: const Size(30, 30),
          buttonSize: const Size(50, 50),
        ),
        const SizedBox(width: 10),
        ZegoLeaveButton(
          iconSize: const Size(30, 30),
          buttonSize: const Size(50, 50),
        ),
      ],
    );
  }
}
