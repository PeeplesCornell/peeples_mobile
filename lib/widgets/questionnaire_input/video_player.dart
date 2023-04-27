import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final bool isThumbnail;

  const VideoPage({Key? key, required this.filePath, required this.isThumbnail})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));

    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.initialize();
    if (!widget.isThumbnail) {
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController.value.isInitialized) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            )),
        body: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController)),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
