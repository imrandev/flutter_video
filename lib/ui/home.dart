import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/ui/list/video_list_view.dart';
import 'package:flutter_video/utils/constant.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoBloc _videoBloc = BlocProvider.of<VideoBloc>(context);
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
      body: StreamBuilder<List<Media>>(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? VideoListView(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
        stream: _videoBloc.videoListStream,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePath.videoRecord);
        },
        child: Icon(
          Icons.video_call,
          color: Colors.white,
        ),
      ),
    );
  }
}
