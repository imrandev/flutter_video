import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc extends BlocBase {

  final _videoListBehavior = BehaviorSubject<List<Video>>();

  Stream<List<Video>> get videoListStream => _videoListBehavior.stream;

  Function(List<Video>) get _videoListSink => _videoListBehavior.sink.add;

  init(BuildContext context) async {
    _videoListSink(ApiProvider()
        .parseJson(await ApiProvider().loadJsonFromLocalPath(context)));
  }

  @override
  void dispose() {
    _videoListBehavior.close();
  }
}