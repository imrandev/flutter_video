import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/network/remote/model/question.dart';
import 'package:flutter_video/network/remote/model/upload_response.dart';
import 'package:flutter_video/ui/widgets/dialog_video_player.dart';
import 'package:flutter_video/utils/constant.dart';

class VideoResumeList extends StatelessWidget {
  final List<Question> questionList;

  VideoResumeList(this.questionList);

  @override
  Widget build(BuildContext context) {
    VideoBloc _videoBloc = BlocProvider.of<VideoBloc>(context);

    _videoBloc.questionsStream.listen((event) {
      if (event != null && event.message != null) {
        print(event.message);
      }
    });

    return ListView.builder(
      itemCount: questionList.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            child: ListTile(
              leading: Image.asset('assets/play.png'),
              title: InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogVideoPlayer(
                        new Media(
                          int.tryParse(questionList[index].slNo) ?? 0,
                          questionList[index].questionText,
                          questionList[index].videoUrl,
                          questionList[index].videoUrl.split('/').last,
                        )
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    '${questionList[index].questionTextBng}',
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                    ),
                    onPressed: () {

                    },
                  ),
                  StreamBuilder<UploadResponse>(
                    builder: (context, snapshot) {
                      return snapshot.hasData && snapshot.data.statuscode == ApiStatus.crudSuccess
                          ? Icon(
                        Icons.check_circle_outline,
                      ) : IconButton(
                        icon: Icon(
                          Icons.cloud_upload,
                        ),
                        onPressed: () {
                          _videoBloc
                              .uploadVideo(questionList[index].videoUrl);
                        },
                      );
                    },
                    stream: _videoBloc.fileUploadStream,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
