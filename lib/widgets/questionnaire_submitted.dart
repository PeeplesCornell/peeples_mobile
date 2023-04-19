import 'package:flutter/material.dart';

class QuestionnaireSubmitted extends StatelessWidget {
  const QuestionnaireSubmitted(
      {Key? key, required this.earnedPoints, required this.totalPoints})
      : super(key: key);

  final int earnedPoints;
  final int totalPoints;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Thank you!"),
      const Text("You have earned: "),
      Text("$earnedPoints",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green)),
      Text("Total points: ${earnedPoints + totalPoints}")
    ]);
  }
}
