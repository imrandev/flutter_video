import 'package:flutter/material.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/ui/widgets/dialog_video_player.dart';

class VideoListView extends StatelessWidget {

  final List<Media> videoList;

  VideoListView(this.videoList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            child: ListTile(
              leading: Image.asset('assets/play.png'),
              title: InkWell(
                onTap: (){
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogVideoPlayer(videoList[index]);
                    },
                  );
                },
                child: Text(
                  '${videoList[index].title}',
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.cloud_upload,
                ),
                onPressed: () {
                  
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
