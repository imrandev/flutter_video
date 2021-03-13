import 'package:flutter/material.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/ui/widgets/dialog_video_player.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:flutter_video/utils/path_arguments.dart';

class VideoListView extends StatelessWidget {

  final List<Video> videoList;

  VideoListView(this.videoList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            /*Navigator.pushNamed(context, RoutePath.player,
              arguments: PathArguments(
                video: videoList[index],
              ),
            );*/

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return DialogVideoPlayer(videoList[index]);
              },
            );
          },
          child: Card(
            child: Container(
              child: ListTile(
                leading: Image.asset(videoList[index].image),
                title: Text(
                  '${videoList[index].title}',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
