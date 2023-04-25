import 'package:flutter/material.dart';
import 'package:peeples/widgets/questionnaire_input/multiselect_input.dart';
import 'package:peeples/widgets/questionnaire_input/text_input.dart';
import 'package:peeples/widgets/questionnaire_input/video_input.dart';

import '../../models/questionnaire_models/QuestionResponseType.dart';

class DynamicQuestionInput extends StatelessWidget {
  const DynamicQuestionInput(
      {Key? key,
      required this.type,
      this.response,
      this.multiselectOptions,
      required this.updateResponseCallback})
      : super(key: key);

  final QuestionResponseType type;
  final String? response;
  final List<String>? multiselectOptions;
  final void Function(String?) updateResponseCallback;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case QuestionResponseType.text:
        return TextInput(
            updateResponseCallback: updateResponseCallback, response: response);
      case QuestionResponseType.multiselect:
        return MultiSelectInput(
          updateResponseCallback: updateResponseCallback,
          response: response,
          options: multiselectOptions!,
        );
      case QuestionResponseType.video:
        return VideoInput(
            updateResponseCallback: updateResponseCallback, response: response);
      default:
        return Container();
    }
  }
}
