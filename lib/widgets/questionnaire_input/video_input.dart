import 'package:flutter/material.dart';
import 'package:peeples/widgets/questionnaire_input/camera.dart';
import 'package:peeples/widgets/questionnaire_input/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      Camera(callbackFunc: widget.updateResponseCallback),
                ),
              );
            },
            child: const Text("Record Video")),
      );
    } else {
      // TODO: LAYOUT VIDEO - need to refine layout for video preview
      return FutureBuilder(
        future: VideoThumbnail.thumbnailData(
          video: widget.response!,
          imageFormat: ImageFormat.JPEG,
          quality: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            return Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                              filePath: widget.response!,
                              isThumbnail: false,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.memory(snapshot.data!),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      )),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            widget.updateResponseCallback(null);
                          },
                          icon: const Icon(Icons.close_outlined)))
                ],
              ),
            );
          } else {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          }
        },
      );
    }
  }
}
