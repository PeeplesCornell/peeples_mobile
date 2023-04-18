import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/authentication.dart';

// class Questionnaire extends ConsumerWidget {
//   const Questionnaire({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Questionnaire'),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           future: ref.read(firebaseProvider.notifier).getQuestionnaire(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               debugPrint(snapshot.error.toString());
//               return const Text('Something went wrong');
//             } else if (snapshot.connectionState == ConnectionState.done) {
//               return QuestionnaireView(questions: snapshot.data!);
//             } else {
//               return const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(
//                   Colors.deepPurple,
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class QuestionnaireView extends StatefulWidget {
//   final List<String> questions;
//   const QuestionnaireView({Key? key, required this.questions})
//       : super(key: key);

//   @override
//   State<QuestionnaireView> createState() => _QuestionnaireViewState();
// }

// class _QuestionnaireViewState extends State<QuestionnaireView> {
//   int _index = 0;
//   late List<Widget> questionViews;
//   late List<String> _answers =
//       List.generate(widget.questions.length, (index) => "");

//   @override
//   void initState() {
//     questionViews = widget.questions
//         .asMap()
//         .map((index, value) => MapEntry(
//             index,
//             TextQuestion(
//               key: Key(index.toString()),
//               question: value,
//             )))
//         .values
//         .toList();
//     super.initState();
//   }

//   void _nextPage() {
//     setState(() {
//       _index += 1;
//     });
//   }

//   void _previousPage() {
//     setState(() {
//       _index -= 1;
//     });
//   }

//   void _updateAnswer(String updatedValue) {
//     setState(() {
//       _answers = [
//         ..._answers.sublist(0, _index),
//         updatedValue,
//         ..._answers.sublist(_index + 1)
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> buttons = [
//       _index != 0
//           ? TextButton(onPressed: _previousPage, child: const Text("Previous"))
//           : Container(),
//       _index < widget.questions.length - 1
//           ? TextButton(onPressed: _nextPage, child: const Text("Next"))
//           : TextButton(onPressed: () {}, child: const Text("Submit")),
//     ];
//     return Center(
//         child: Column(
//       children: [
//         questionViews[_index],
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: buttons,
//         )
//       ],
//     ));
//   }
// }

// class TextQuestion extends StatefulWidget {
//   final String question;
//   final String? answer;
//   final void Function(String)? previous;
//   final void Function(String)? next;
//   const TextQuestion(
//       {Key? key, required this.question, this.answer, this.previous, this.next})
//       : super(key: key);

//   @override
//   _TextQuestionState createState() => _TextQuestionState();
// }

// class _TextQuestionState extends State<TextQuestion> {
//   final _textController = TextEditingController();

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final textController = TextEditingController(text: widget.answer);
//     return Column(
//       children: [
//         Text(widget.question),
//         TextField(
//           controller: _textController,
//         ),
//       ],
//     );
//   }
// }
