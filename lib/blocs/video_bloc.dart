import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/app_database.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc extends BlocBase {

  var _videoListBehavior = new BehaviorSubject<List<Media>>();
  final _cameraListBehavior = BehaviorSubject<List<CameraDescription>>();

  Stream<List<Media>> get videoListStream => _videoListBehavior.stream;
  Stream<List<CameraDescription>> get cameraListStream => _cameraListBehavior.stream;

  Function(List<Media>) get _videoListSink => _videoListBehavior.sink.add;
  Function(List<CameraDescription>) get _cameraListSink => _cameraListBehavior.sink.add;


  Future<List<CameraDescription>> initCam() async {
    return await availableCameras();
  }

  void setCameras(List<CameraDescription> cameras){
    _cameraListSink(cameras);
  }

  Future<void> saveVideoToLocal(Video video) async {

    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final mediaDao = database.mediaDao;
    int id = 1;

    mediaDao.findLastMedia().then((media) async {
      if (media != null) {
        id = media.id + 1;
      }
      final newMedia = Media(id, video.title, video.playbackUrl, video.fileType);
      await mediaDao.insertMedia(newMedia);
      List<Media> mediaList = _videoListBehavior.value;
      mediaList.add(newMedia);
      _videoListSink(mediaList);
    });
  }

  Future<List<Media>> getListOfVideoFromLocalDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final mediaDao = database.mediaDao;
    return await mediaDao.findAll();
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
    _videoListSink(await getListOfVideoFromLocalDatabase());
  }
}