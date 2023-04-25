import 'package:peeples/models/MerchantModel.dart';
import 'package:peeples/models/questionnaire_models/QuestionModel.dart';

class QuestionnaireModel {
  final List<QuestionModel> questions;
  final int points;
  final MerchantModel merchant;
  final String id;

  QuestionnaireModel(
      {required this.id,
      required this.questions,
      required this.points,
      required this.merchant});

  // from firestore
  factory QuestionnaireModel.fromFirestore(
      String id, Map<String, dynamic> json) {
    return QuestionnaireModel(
        id: id,
        questions: List<Map<String, dynamic>>.from(json['questions'])
            .map((e) => QuestionModel.fromFirestore(e))
            .toList(),
        points: json['points'],
        merchant: MerchantModel());
  }
}
