import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  bool _initialized = false;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initVideoPlayer();
    super.initState();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    Future.delayed(Duration(milliseconds: 2000));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    print("set play");
    await _videoPlayerController.play().then((_) => print("playing"));
    setState(() {
      _initialized = true;
    });
    print("IS PLAYING? " + _videoPlayerController.value.isPlaying.toString());
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Preview'),
  //       elevation: 0,
  //       backgroundColor: Colors.black26,
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.check),
  //           onPressed: () {
  //             print('do something with the file');
  //           },
  //         )
  //       ],
  //     ),
  //     extendBodyBehindAppBar: true,
  //     body: FutureBuilder(
  //       future: _initVideoPlayer(),
  //       builder: (context, state) {
  //         if (state.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else {
  //           return VideoPlayer(_videoPlayerController);
  //         }
  //       },
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: _initVideoPlayer(),
  //     builder: (context, state) {
  //       if (state.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else {
  //         return _videoPlayerController.value.isInitialized
  //             ? AspectRatio(
  //                 aspectRatio: _videoPlayerController.value.aspectRatio,
  //                 child: VideoPlayer(_videoPlayerController))
  //             : Container();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController))
          : Container();
    }
    return const Center(child: CircularProgressIndicator());
  }
}
