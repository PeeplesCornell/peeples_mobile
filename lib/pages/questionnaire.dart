import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/models/questionnaire_models/QuestionModel.dart';
import 'package:peeples/models/questionnaire_models/QuestionnaireModel.dart';
import '../utils/authentication.dart';
import '../widgets/questionnaire_input_widgets/dynamic_input.dart';
import '../widgets/questionnaire_submitted.dart';

class Questionnaire extends ConsumerWidget {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: ref.read(firebaseProvider.notifier).getQuestionnaire(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final QuestionnaireModel questionnaireModel =
                    QuestionnaireModel.fromFirestore(snapshot.data!);
                return QuestionnaireView(
                    questionModels: questionnaireModel.questions);
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
      ),
    );
  }
}

class QuestionnaireView extends StatefulWidget {
  final List<QuestionModel> questionModels;
  const QuestionnaireView({Key? key, required this.questionModels})
      : super(key: key);

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  int _index = 0;
  bool _didSubmit = false;
  late List<String?> _responses =
      List.generate(widget.questionModels.length, (index) => null);

  void _nextPage() {
    setState(() {
      _index += 1;
    });
  }

  void _previousPage() {
    setState(() {
      _index -= 1;
    });
  }

  void _saveAnswer(String updatedResponse) {
    setState(() {
      _responses = [
        ..._responses.sublist(0, _index),
        updatedResponse,
        ..._responses.sublist(_index + 1)
      ];
    });
  }

  void _onSubmit() {
    setState(() {
      _didSubmit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_didSubmit) {
      return const QuestionnaireSubmitted(
        earnedPoints: 300,
        totalPoints: 1200,
      );
    }

    final bool isFirstQuestion = _index == 0;
    final bool isLastQuestion = _index == widget.questionModels.length - 1;
    final bool isNextStepEnabled =
        _responses[_index] != null && _responses[_index] != "";

    final Widget previousButtonOrContainer = isFirstQuestion
        ? Container()
        : TextButton(onPressed: _previousPage, child: const Text("Previous"));
    final Widget nextOrSubmitButton = isLastQuestion
        ? TextButton(
            onPressed: isNextStepEnabled ? _onSubmit : null,
            child: const Text("Submit"))
        : TextButton(
            onPressed: isNextStepEnabled ? _nextPage : null,
            child: const Text("Next"));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Column(
          children: [
            Text(widget.questionModels[_index].question),
            DynamicInput(
              key: Key(_index.toString()),
              type: widget.questionModels[_index].type,
              response: _responses[_index],
              updateResponseCallback: _saveAnswer,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [previousButtonOrContainer, nextOrSubmitButton],
        )
      ],
    );
  }
}
