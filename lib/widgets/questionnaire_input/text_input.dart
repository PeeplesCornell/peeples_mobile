import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? response;
  final void Function(String?) updateResponseCallback;
  const TextInput(
      {Key? key, this.response, required this.updateResponseCallback})
      : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.addListener(() {
      if (widget.response != _textController.text) {
        widget.updateResponseCallback(_textController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    // TODO: dismiss keyboard; FocusManager.instance.primaryFocus is null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response != null) {
      _textController.text = widget.response!;
      _textController.selection =
          TextSelection.collapsed(offset: _textController.text.length);
    }
    return TextField(
      controller: _textController,
    );
  }
}
