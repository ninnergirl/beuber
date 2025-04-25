class VideoController {
  static String generateCallID(String courseId, String tutorId) {
    return '$courseId-$tutorId-${DateTime.now().millisecondsSinceEpoch}';
  }
}
