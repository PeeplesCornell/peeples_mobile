import 'package:peeples/models/questionnaire_models/QuestionResponseType.dart';

class QuestionModel {
  final String question;
  final QuestionResponseType type;
  // Options is not null only when type == "multiselect"
  final List<String>? options;

  QuestionModel({required this.question, required this.type, this.options});

  // from firestore
  factory QuestionModel.fromFirestore(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'],
        type: QuestionResponseType.fromString(json['type']),
        options: json.containsKey('options')
            ? List<String>.from(json['options'])
            : null);
  }
}
