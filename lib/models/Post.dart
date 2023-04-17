import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final List<String> comments;
  final String content;
  final int earnings;
  final String location;
  final double rating;
  final String userAvatar;
  final String userName;
  final Timestamp visitTime;
  final String merchantName;

  Post({
    required this.comments,
    required this.content,
    required this.earnings,
    required this.location,
    required this.rating,
    required this.userAvatar,
    required this.userName,
    required this.visitTime,
    required this.merchantName,
  });

  // from firestore
  factory Post.fromFirestore(Map<String, dynamic> json) {
    return Post(
      // list of dynamic to list of string
      comments: List<String>.from(json['comments']),
      content: json['content'],
      earnings: json['earning'],
      location: json['location'],
      rating: json['rating'],
      userAvatar: json['user_avatar'],
      userName: json['user_name'],
      visitTime: json['visited_time'],
      merchantName: json['merchant_name'],
    );
  }
}
