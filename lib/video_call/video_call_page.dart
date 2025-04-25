import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  final String userID;
  final String callID;

  const VideoCallPage({super.key, required this.userID, required this.callID});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 93397639,
      appSign:
          '3ac7206bc38532818ad6dd52662536cd1247519323c60f190350445186cc700c',
      userID: userID,
      userName: 'user_$userID',
      callID: callID,
      config:
          ZegoUIKitPrebuiltCallConfig.groupVideoCall()
            ..turnOnCameraWhenJoining = true
            ..turnOnMicrophoneWhenJoining = true
            ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
              buttons: [
                ZegoMenuBarButtonName.toggleMicrophoneButton,
                ZegoMenuBarButtonName.toggleCameraButton,
                ZegoMenuBarButtonName.hangUpButton,
              ],
            ),
    );
  }
}
