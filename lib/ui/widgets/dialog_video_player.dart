import 'package:flutter/material.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/ui/player/chewie_video_player.dart';

class DialogVideoPlayer extends StatelessWidget {

  final Media video;

  DialogVideoPlayer(this.video);

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(video.title),
      insetPadding: EdgeInsets.all(5),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height / 2,
        margin: EdgeInsets.only(top: 10,),
        child: ChewieVideoPlayer(video),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
