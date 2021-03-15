import 'package:flutter/material.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/ui/player/chewie_video_player.dart';

class VideoCamPlayer extends StatelessWidget {

  final Video video;

  VideoCamPlayer(this.video);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.video_library,
          color: Colors.white,
        ),
        title: Text(
          '${video.title}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: ChewieVideoPlayer(new Media(1, video.title, video.playbackUrl, ""),),
      ),
    );
  }
}
