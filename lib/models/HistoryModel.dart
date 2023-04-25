import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final Timestamp time;
  final String points;
  final String merchantName;
  final String type;
  final String merchantImg;

  HistoryModel({
    required this.time,
    required this.points,
    required this.merchantName,
    required this.type,
    required this.merchantImg,
  });

  // from firestore
  @override
  factory HistoryModel.fromFirestore(Map<String, dynamic> json) {
    return HistoryModel(
        // list of dynamic to list of string
        time: json['time'],
        points: json['points'],
        merchantName: json['merchant_name'],
        type: json['type'],
        merchantImg: json['merchant_img']);
  }
}
