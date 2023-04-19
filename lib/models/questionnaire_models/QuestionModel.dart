import 'package:peeples/models/questionnaire_models/QuestionResponseType.dart';

class QuestionModel {
  final String question;
  final QuestionResponseType type;

  QuestionModel({required this.question, required this.type});

  // from firestore
  factory QuestionModel.fromFirestore(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'],
        type: QuestionResponseType.fromString(json['type']));
  }
}
