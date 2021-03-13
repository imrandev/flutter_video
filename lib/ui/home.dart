import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/ui/list/video_list_view.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoBloc _videoBloc = BlocProvider.of<VideoBloc>(context);
    _videoBloc.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.video_library,
          color: Colors.white,
        ),
        title: Text(
          'My Videos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<List<Video>>(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? VideoListView(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
        stream: _videoBloc.videoListStream,
      ),
    );
  }
}
