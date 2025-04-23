class VideoService {
  static Future<void> startCall(String userID, String callID) async {
    print('Call started for $userID with callID: $callID');
  }

  static Future<void> endCall(String callID) async {
    print('Call ended for callID: $callID');
  }
}
