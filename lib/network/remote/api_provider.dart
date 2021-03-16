
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_video/network/remote/model/upload_response.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:http_parser/http_parser.dart';

class ApiProvider {
  static final ApiProvider instance = ApiProvider._internal();

  final _dio = Dio(
    BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Constant.connectionTimeout,
      receiveTimeout: Constant.receiveTimeout,
    ),
  );

  factory ApiProvider() {
    return instance;
  }

  ApiProvider._internal();

  Future<UploadResponse> uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    MultipartFile _multiPartFile = MultipartFile.fromFileSync(
      file.path,
      filename: fileName,
    );

    FormData formData = FormData.fromMap({
      "userid" : "4361771",
      "decodeid" : "S8A8Qw",
      "questionid" : "1",
      "questionduration" : "30",
      "questionserialno" : "1",
      "devicetype" : "Android",
      "browserinfo" : "",
      "appid" : "1",
      "lang" : "EN"
    });

    formData.files.add(MapEntry("file", _multiPartFile));

    UploadResponse _uploadResponse = new UploadResponse();

    _dio.interceptors.add(LogInterceptor());

    _dio.post(Constant.uploadVideoResumeAnswer, data: formData).then((response) {
      if (response.statusCode == ApiStatus.ok) {
        _uploadResponse = UploadResponse.fromJson(response.data);
      } else {
        _uploadResponse.statuscode = response.statusCode.toString();
        _uploadResponse.message = response.statusMessage;
      }
    }).catchError((e) {
      _uploadResponse.statuscode = "-1";
      _uploadResponse.message = e.error.message;
    });
    return _uploadResponse;
  }
}