import 'package:peeples/models/MerchantModel.dart';
import 'package:peeples/models/questionnaire_models/QuestionModel.dart';

class QuestionnaireModel {
  final List<QuestionModel> questions;
  final int score;
  final MerchantModel merchant;

  QuestionnaireModel(
      {required this.questions, required this.score, required this.merchant});

  // from firestore
  factory QuestionnaireModel.fromFirestore(Map<String, dynamic> json) {
    return QuestionnaireModel(
        questions: List<Map<String, dynamic>>.from(json['questions'])
            .map((e) => QuestionModel.fromFirestore(e))
            .toList(),
        score: json['score'],
        merchant: MerchantModel());
  }
}
