import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/app_database.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/repository/video_repository.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc extends BlocBase {

  final _videoListBehavior = new BehaviorSubject<List<Media>>();

  final _cameraListBehavior = BehaviorSubject<List<CameraDescription>>();

  Stream<List<Media>> get videoListStream => _videoListBehavior.stream;

  Stream<List<CameraDescription>> get cameraListStream => _cameraListBehavior.stream;

  Function(List<Media>) get _videoListSink => _videoListBehavior.sink.add;

  Function(List<CameraDescription>) get _cameraListSink => _cameraListBehavior.sink.add;

  VideoRepository _videoRepository;

  Future<List<CameraDescription>> initCam() async {
    return await availableCameras();
  }

  void setCameras(List<CameraDescription> cameras){
    _cameraListSink(cameras);
  }

  Future<void> saveVideo(Video video) async {
    int id = await _videoRepository.add(video);
    // update list
    List<Media> mediaList = _videoListBehavior.value;
    mediaList.add(Media(id, video.title, video.playbackUrl, video.fileType));
    _videoListSink(mediaList);
  }

  Future<List<Media>> getVideos() async {
    return await _videoRepository.get();
  }

  void deleteVideo(Media media) async{
    if (await _videoRepository.delete(media)) {
      List<Media> mediaList = _videoListBehavior.value;
      mediaList.remove(media);
      _videoListSink(mediaList);
    }
  }

  @override
  void dispose() {
    _videoListBehavior.close();
    _cameraListBehavior.close();
  }

  @override
  void init(BuildContext context) async {
    /*_videoListSink(ApiProvider()
        .parseJson(await ApiProvider().loadJsonFromLocalPath(context)));*/
    // initialize database
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    // initialize repository
    _videoRepository = new VideoRepository(database.mediaDao);
    _videoListSink(await _videoRepository.get());
    saveVideo(new Video(
      id: 23,
      title: "sample",
      playbackUrl: await _videoRepository.download(),
    ));
  }
}