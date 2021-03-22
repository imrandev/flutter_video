import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/utils/file_util.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() {
    return _instance;
  }

  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://vdo.bdjobs.com",
    ),
  );

  ApiProvider._internal();

  // load local json file from assets
  Future<String> loadJsonFromLocalPath(BuildContext context){
    return DefaultAssetBundle.of(context).loadString('assets/videos.json');
  }

  // parse json response data from a local json file
  List<Video> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Video>((json) => new Video.fromJson(json)).toList();
  }

  Future<String> downloadVideo() async {
    String savePath = await FileUtil().getFilePath("mp4");
    print("$savePath");
    _dio.download("/Videos/Corporate//909911/185264754/185264754_2.webm", savePath, onReceiveProgress: (receive, total) {
      double percentage = (receive * 100) / total;
      print("Downloaded $percentage%");
    }).then((response) {
      print("${response.data.toString()}");
    }).catchError((e) {
      print("${e.toString()}");
    });
    return savePath;
  }
}