import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/app_database.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/network/remote/model/question_response.dart';
import 'package:flutter_video/network/remote/model/upload_response.dart';
import 'package:flutter_video/repository/video_repository.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc extends BlocBase {

  final _videoListBehavior = BehaviorSubject<List<Media>>();

  final _cameraListBehavior = BehaviorSubject<List<CameraDescription>>();

  final _fileUploadBehavior = BehaviorSubject<UploadResponse>();

  final _questionsBehavior = BehaviorSubject<QuestionResponse>();

  Stream<List<Media>> get videoListStream => _videoListBehavior.stream;

  Stream<List<CameraDescription>> get cameraListStream => _cameraListBehavior.stream;

  Stream<UploadResponse> get fileUploadStream => _fileUploadBehavior.stream;

  Stream<QuestionResponse> get questionsStream => _questionsBehavior.stream;

  Function(List<Media>) get _videoListSink => _videoListBehavior.sink.add;

  Function(List<CameraDescription>) get _cameraListSink => _cameraListBehavior.sink.add;

  Function(UploadResponse) get _fileUploadSink => _fileUploadBehavior.sink.add;

  Function(QuestionResponse) get _questionsSink => _questionsBehavior.sink.add;

  VideoRepository _videoRepository;

  @override
  void init(BuildContext context) async {
    /*_videoListSink(ApiProvider()
        .parseJson(await ApiProvider().loadJsonFromLocalPath(context)));*/
    // initialize database
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    // initialize repository
    _videoRepository = new VideoRepository(database.mediaDao);
    fetchQuestions();
  }

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

  void uploadVideo(String filepath) async {
    _fileUploadSink(await _videoRepository.uploadVideo(File(filepath)));
  }

  void fetchQuestions() async {
    Map<String, dynamic> requestBody = <String, dynamic>{
      "userId" : Constant.userId,
      "decodeId" : Constant.decodeId,
      "appId" : "1",
      "lang" : "EN"
    };
    QuestionResponse _questionResponse = await _videoRepository.fetchQuestionList(requestBody);
    _questionsSink(_questionResponse);
  }

  @override
  void dispose() {
    _videoListBehavior.close();
    _cameraListBehavior.close();
    _fileUploadBehavior.close();
    _questionsBehavior.close();
  }

  Future<String> webmToMp4(Media source){
    return _videoRepository.webmToMp4(source);
  }
}