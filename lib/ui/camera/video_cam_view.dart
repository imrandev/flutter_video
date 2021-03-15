import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:flutter_video/utils/file_util.dart';
import 'package:flutter_video/utils/path_arguments.dart';
import 'package:video_player/video_player.dart';

class VideoCamView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _VideoCamState();
}

class _VideoCamState extends State<VideoCamView> {

  String imagePath;
  bool _toggleCamera = false;
  bool _startRecording = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CameraController controller;
  VideoBloc _videoBloc;

  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;

  @override
  void initState() {
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _videoBloc.initCam().then((cameras) {
      if (cameras != null && cameras.isNotEmpty) {
        try {
          onCameraSelected(cameras[0]);
          _videoBloc.setCameras(cameras);
        } catch (e) {
          print(e.toString());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CameraDescription>>(
      builder: (context, snapshot) {
        return snapshot.hasData && snapshot.data.isNotEmpty
            ? !controller.value.isInitialized
                ? Container()
                : AspectRatio(
                    key: _scaffoldKey,
                    aspectRatio: controller.value.aspectRatio,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          CameraPreview(controller),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 120.0,
                              padding: EdgeInsets.all(20.0),
                              color: Color.fromRGBO(00, 00, 00, 0.7),
                              child: Stack(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        onTap: () {
                                          !_startRecording
                                              ? onVideoRecordButtonPressed()
                                              : onStopButtonPressed();
                                          setState(() {
                                            _startRecording = !_startRecording;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            !_startRecording
                                                ? Icons.play_circle_outline
                                                : Icons.stop_circle,
                                            size: 72.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  !_startRecording
                                      ? _getToggleCamera(snapshot.data)
                                      : new Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No Camera Found!',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              );
      },
      stream: _videoBloc.cameraListStream,
    );
  }

  Widget _getToggleCamera(List<CameraDescription> cameras) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          onTap: () {
            !_toggleCamera
                ? onCameraSelected(cameras[1])
                : onCameraSelected(cameras[0]);
            setState(() {
              _toggleCamera = !_toggleCamera;
            });
          },
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.switch_camera,
              color: Colors.grey[200],
              size: 42.0,
            ),
          ),
        ),
      ),
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showSnackBar('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showException(e);
    }

    if (mounted) setState(() {});
  }

  void onVideoRecordButtonPressed() {
    print('onVideoRecordButtonPressed()');
    startVideoRecording().whenComplete(() {
      if (mounted) setState(() {});
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> startVideoRecording() async {

    if (!controller.value.isInitialized) {
      showSnackBar('Error: select a camera first.');
      return null;
    }

    if (controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      _showException(e);
      return null;
    }
  }


  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return;
    }
    try {
      String newFilePath = await FileUtil().getFilePath();
      String filename = FileUtil().getFilename();
      await controller.stopVideoRecording().then(
        (value) {
          // file copy from cache into the new destination
          File(value.path).copy(newFilePath).then(
            (file) async {
              if (await file.exists()) {
                print("Video saved in ${file.path}");
                Video _video = new Video(
                  title: filename,
                  playbackUrl: newFilePath,
                );
                // save file info to local database
                _videoBloc.saveVideoToLocal(_video).whenComplete(
                  () {
                    // show preview of video file
                    Navigator.pushNamed(
                      context,
                      RoutePath.playVideo,
                      arguments: PathArguments(
                        video: _video,
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      );
    } on CameraException catch (e) {
      _showException(e);
      return;
    }
  }

  void _showException(CameraException e) {
    logError(e.code, e.description);
    showSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showSnackBar(String message) {
    print(message);
  }

  void logError(String code, String message) => print('Error: $code\nMessage: $message');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
