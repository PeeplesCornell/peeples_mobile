import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/models/questionnaire_models/QuestionnaireModel.dart';
import 'package:peeples/widgets/questionnaire_header.dart';
import '../utils/authentication.dart';
import '../widgets/questionnaire_input/dynamic_input.dart';
import '../widgets/questionnaire_submitted.dart';

class Questionnaire extends ConsumerWidget {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(firebaseProvider.notifier).getQuestionnaire(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            final QuestionnaireModel questionnaireModel = snapshot.data!;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  AppBar(
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    flexibleSpace: const QuestionnaireHeader(),
                  ),
                  Expanded(
                      child: QuestionnaireView(
                          questionnaireModel: questionnaireModel)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Text('Something went wrong');
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.deepPurple,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class QuestionnaireView extends ConsumerStatefulWidget {
  final QuestionnaireModel questionnaireModel;
  const QuestionnaireView({Key? key, required this.questionnaireModel})
      : super(key: key);

  @override
  ConsumerState<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends ConsumerState<QuestionnaireView> {
  int _questionIndex = 0;
  bool _didSubmit = false;
  late final List<String?> _responses =
      List.generate(widget.questionnaireModel.questions.length, (_) => null);

  void _nextPage() {
    setState(() {
      _questionIndex += 1;
    });
  }

  void _previousPage() {
    setState(() {
      _questionIndex -= 1;
    });
  }

  void _saveResponse(String? updatedResponse) {
    setState(() {
      _responses[_questionIndex] = updatedResponse;
    });
  }

  void _onSubmit() {
    ref.read(firebaseProvider.notifier).submitQuestionnaire(
        widget.questionnaireModel, _responses.map((e) => e!).toList());
    setState(() {
      _didSubmit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_didSubmit) {
      return QuestionnaireSubmitted(
        earnedPoints: widget.questionnaireModel.points,
        totalPoints: 1200, // TODO: HARD CODED
      );
    }

    final bool isFirstQuestion = _questionIndex == 0;
    final bool isLastQuestion =
        _questionIndex == widget.questionnaireModel.questions.length - 1;
    final bool isNextStepEnabled =
        _responses[_questionIndex] != null && _responses[_questionIndex] != "";

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

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question text
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Text(
                    widget
                        .questionnaireModel.questions[_questionIndex].question,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),

                // Input widget
                DynamicQuestionInput(
                  key: Key(_questionIndex.toString()),
                  type:
                      widget.questionnaireModel.questions[_questionIndex].type,
                  response: _responses[_questionIndex],
                  updateResponseCallback: _saveResponse,
                  multiselectOptions: widget
                      .questionnaireModel.questions[_questionIndex].options,
                ),
              ],
            ),
          ),

          // Previous & Next buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [previousButtonOrContainer, nextOrSubmitButton],
          )
        ],
      ),
    );
  }
}
