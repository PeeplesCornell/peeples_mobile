import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/authentication.dart';
import 'package:survey_kit/survey_kit.dart';

class Questionnaire extends ConsumerWidget {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire'),
      ),
      body: Center(
        child: FutureBuilder(
          future: ref.read(firebaseProvider.notifier).getQuestionnaire(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              final steps = [
                QuestionStep(
                  title: 'Sample title',
                  text: 'Sample text',
                  answerFormat: const TextAnswerFormat(
                    maxLines: 5,
                  ),
                ),
                QuestionStep(
                  title: 'Sample title',
                  text: 'Sample text',
                  answerFormat: const TextAnswerFormat(
                    maxLines: 5,
                  ),
                ),
              ];
              final surveyTask =
                  NavigableTask(id: TaskIdentifier(), steps: steps);
              return SurveyKit(
                  onResult: (SurveyResult result) {
                    print(result.finishReason);
                    print(result.results.toString());
                  },
                  task: surveyTask);
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Text('Something went wrong');
            } else {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.deepPurple,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
