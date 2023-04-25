import 'package:flutter/material.dart';
import 'package:peeples/widgets/questionnaire_input/camera.dart';
import 'package:peeples/widgets/questionnaire_input/video_player.dart';

class VideoInput extends StatefulWidget {
  final String? response;
  final void Function(String?) updateResponseCallback;

  const VideoInput(
      {Key? key, required this.updateResponseCallback, required this.response})
      : super(key: key);

  @override
  _VideoInputState createState() => _VideoInputState();
}

class _VideoInputState extends State<VideoInput> {
  @override
  Widget build(BuildContext context) {
    final bool hasRecorded = widget.response != null && widget.response != "";
    if (!hasRecorded) {
      return TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    Camera(callbackFunc: widget.updateResponseCallback),
              ),
            );
          },
          child: const Text("Record Video"));
    } else {
      // TODO: LAYOUT - need to refine layout for video preview
      return Flexible(
          child: Row(
        children: [
          VideoPage(filePath: widget.response!),
          IconButton(
              onPressed: () {
                widget.updateResponseCallback(null);
              },
              icon: const Icon(Icons.close_outlined))
        ],
      ));
    }
  }
}
