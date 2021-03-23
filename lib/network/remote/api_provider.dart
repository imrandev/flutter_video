
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_video/network/remote/model/question_response.dart';
import 'package:flutter_video/network/remote/model/upload_response.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:flutter_video/utils/file_util.dart';
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

  Future<QuestionResponse> findQuestions(Map<String, dynamic> requestBody) async {
    QuestionResponse _questionResponse = QuestionResponse();
    _dio.interceptors.add(LogInterceptor());
    await _dio.post(
      Constant.uploadVideoResumeQuestionList,
      data: requestBody,
      options: Options(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
      )
    ).then((response) {
      if (response.statusCode == ApiStatus.ok) {
        _questionResponse = QuestionResponse.fromJson(response.data);
      } else {
        _questionResponse.statuscode = response.statusCode.toString();
        _questionResponse.message = response.statusMessage;
      }
    }).catchError((e) {
      _questionResponse.statuscode = "-1";
      _questionResponse.message = e.toString();
    });
    return _questionResponse;
  }

  Future<UploadResponse> uploadFile(File file) async {

    file = await FileUtil().getImageFile();
    UploadResponse _uploadResponse = new UploadResponse();
    String fileName = file.path.split('/').last;
    MultipartFile _multiPart = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    );

    /*FormData _formData = FormData.fromMap(<String, dynamic>{
      "userId" : "4361771",
      "decodeId" : "S8A8Qw",
      "file" : _multiPart,
      "questionId" : "1",
      "questionDuration" : "30",
      "questionSerialNo" : "1",
      "browserInfo" : "",
      "appId" : "1",
      "lang" : "EN"
    });*/

    FormData formData = new FormData();
    formData.fields.add(MapEntry("userId", "4361771"));
    formData.fields.add(MapEntry("decodeId", "S8A8Qw"));
    formData.fields.add(MapEntry("questionId", "1"));
    formData.fields.add(MapEntry("questionDuration", "30"));
    formData.fields.add(MapEntry("questionSerialNo", "1"));
    formData.fields.add(MapEntry("deviceType", "Android"));
    formData.fields.add(MapEntry("browserInfo", ""));
    formData.fields.add(MapEntry("appId", "1"));
    formData.fields.add(MapEntry("lang", "EN"));
    formData.files.add(MapEntry("file", _multiPart));
    _dio.interceptors.add(LogInterceptor());
    _dio.post(Constant.uploadVideoResumeAnswer, data: formData, onSendProgress: (count, total) {
      print("Send : $count");
      print("Total : $total");
    },).then((response) {
      if (response.statusCode == ApiStatus.ok) {
        _uploadResponse = UploadResponse.fromJson(response.data);
      } else {
        _uploadResponse.statuscode = response.statusCode.toString();
        _uploadResponse.message = response.statusMessage;
      }
    }).catchError((e) {
      _uploadResponse.statuscode = "-1";
      _uploadResponse.message = e.toString();
    });
    return _uploadResponse;
  }

  Future<String> webmToMp4(String sourcePath) async {
    String savePath = await FileUtil().getFilePath("mp4");
    double percentage = 0.0;
    print("$savePath");
    await _dio.download(sourcePath, savePath, onReceiveProgress: (receive, total) {
      percentage = (receive * 100) / total;
      print("Downloaded ${percentage.floor()}%");
    }).then((response) {
      print("${response.data.toString()}");
    }).catchError((e) {
      print("${e.toString()}");
    });
    return savePath;
  }
}