import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_video/model/video.dart';

class LocalProvider {
  static final LocalProvider _instance = LocalProvider._internal();

  factory LocalProvider() {
    return _instance;
  }

  LocalProvider._internal();

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
}