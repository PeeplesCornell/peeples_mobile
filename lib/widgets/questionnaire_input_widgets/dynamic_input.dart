import 'package:flutter/material.dart';
import 'package:peeples/widgets/questionnaire_input_widgets/text_input.dart';

import '../../models/questionnaire_models/QuestionResponseType.dart';

class DynamicInput extends StatelessWidget {
  const DynamicInput(
      {Key? key,
      required this.type,
      this.response,
      required this.updateResponseCallback})
      : super(key: key);

  final QuestionResponseType type;
  final String? response;
  final void Function(String) updateResponseCallback;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case QuestionResponseType.text:
        return TextInput(
            updateResponseCallback: updateResponseCallback, response: response);
      default:
        return Container();
    }
  }
}
