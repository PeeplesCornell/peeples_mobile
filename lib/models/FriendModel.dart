import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String merchantAvatar;
  final String merchantImg;
  final String merchantName;
  final String location;
  final String friendAvatar;
  final String friendName;
  final Timestamp time;
  final String points;
  final String review;

  FriendModel({
    required this.merchantAvatar,
    required this.merchantImg,
    required this.merchantName,
    required this.location,
    required this.friendAvatar,
    required this.friendName,
    required this.time,
    required this.points,
    required this.review,
  });

  // from firestore
  @override
  factory FriendModel.fromFirestore(Map<String, dynamic> json) {
    return FriendModel(
        // list of dynamic to list of string
        merchantAvatar: json['merchant_avatar'],
        merchantImg: json['merchant_img'],
        merchantName: json['merchant_name'],
        location: json['location'],
        friendAvatar: json['friend_avatar'],
        friendName: json['friend_name'],
        time: json['time'],
        points: json['friend_points'],
        review: json['review']);
  }
}
