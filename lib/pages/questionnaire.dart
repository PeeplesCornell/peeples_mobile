import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/authentication.dart';

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
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return QuestionnaireView(questions: snapshot.data!);
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

class QuestionnaireView extends StatefulWidget {
  final List<String> questions;
  const QuestionnaireView({Key? key, required this.questions})
      : super(key: key);

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  int _index = 0;
  late List<String?> _answers =
      List.generate(widget.questions.length, (index) => null);

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

  void _updateAnswer(String updatedValue) {
    setState(() {
      _answers = [
        ..._answers.sublist(0, _index),
        updatedValue,
        ..._answers.sublist(_index + 1)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextQuestion(
            question: widget.questions[_index],
            answer: _answers[_index],
            previous: _index > 0
                ? (String updatedValue) {
                    _previousPage();
                    _updateAnswer(updatedValue);
                  }
                : null,
            next: _index < widget.questions.length - 1
                ? (String updatedValue) {
                    _nextPage();
                    _updateAnswer(updatedValue);
                  }
                : null));
  }
}

class TextQuestion extends StatefulWidget {
  final String question;
  final String? answer;
  final void Function(String)? previous;
  final void Function(String)? next;
  const TextQuestion(
      {Key? key, required this.question, this.answer, this.previous, this.next})
      : super(key: key);

  @override
  _TextQuestionState createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  late final _textController = TextEditingController(text: widget.answer);

  @override
  void dispose() {
    debugPrint("hei");
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.clear();
    if (widget.answer != null) {
      _textController.text = widget.answer!;
    }
    return Column(
      children: [
        Text(widget.question),
        TextField(
          controller: _textController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.previous != null
                ? TextButton(
                    onPressed: () => widget.previous!(_textController.text),
                    child: const Text("Previous"))
                : Container(),
            widget.next != null
                ? TextButton(
                    onPressed: () => widget.next!(_textController.text),
                    child: const Text("Next"))
                : TextButton(onPressed: () {}, child: const Text("Submit")),
          ],
        )
      ],
    );
  }
}
