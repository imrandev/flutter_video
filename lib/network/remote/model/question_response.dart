import 'package:flutter_video/network/remote/model/question.dart';

class QuestionResponse {
  String statuscode;
  String message;
  List<Question> data;
  Null common;

  QuestionResponse({this.statuscode, this.message, this.data, this.common});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Question>();
      json['data'].forEach((v) {
        data.add(new Question.fromJson(v));
      });
    }
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['common'] = this.common;
    return data;
  }
}