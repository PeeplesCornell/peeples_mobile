import 'package:cloud_firestore/cloud_firestore.dart';

class TimeHelper {
  static String calculateTime(Timestamp ts) {
    DateTime now = DateTime.now();
    DateTime postTime = ts.toDate();
    Duration diff = now.difference(postTime);
    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} seconds ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays ~/ 7} weeks ago";
    } else if (diff.inDays < 365) {
      return "${diff.inDays ~/ 30} months ago";
    } else {
      return "${diff.inDays ~/ 365} years ago";
    }
  }
}
