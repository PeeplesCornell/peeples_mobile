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
              return QuestionnaireView(data: snapshot.data!);
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
  final List<String> data;
  const QuestionnaireView({Key? key, required this.data}) : super(key: key);

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  final int _index = 0;
  late final List<String?> _result =
      List.generate(widget.data.length, (index) => null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextQuestion(question: widget.data[_index]),
    );
  }
}

class TextQuestion extends StatefulWidget {
  final String question;
  const TextQuestion({Key? key, required this.question}) : super(key: key);

  @override
  _TextQuestionState createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  late final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            Text(widget.question),
            TextField(
              controller: _textController,
            ),
          ],
        ),
      ),
    );
  }
}
