import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoPlayer extends StatefulWidget {

  final Media video;

  ChewieVideoPlayer(this.video);

  @override
  State<StatefulWidget> createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewieVideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        '${widget.video.playbackUrl}');
    await Future.wait([
      _videoPlayerController.initialize()
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowPlaybackSpeedChanging: false,
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
        _chewieController
            .videoPlayerController.value.isInitialized
        ? Chewie(
      controller: _chewieController,
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading'),
        ],
      ),
    );
  }
}
