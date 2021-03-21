import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/network/remote/model/question_response.dart';
import 'package:flutter_video/ui/list/video_list_view.dart';
import 'package:flutter_video/ui/list/video_resume_list.dart';
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
          'Video Resume',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuestionResponse>(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data != null && snapshot.data.statuscode == ApiStatus.dataFound
                  ? VideoResumeList(snapshot.data.data)
                  : Center(
                      child: Text("No question found"),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
        stream: _videoBloc.questionsStream,
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
