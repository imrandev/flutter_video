class RoutePath {
  static const String home = "/";
  static const String player = "/player";
  static const String videoRecord = "/record";
  static const String playVideo = "/play-video";
}

class Constant {
  // static const String baseUrl = "https://vdo.bdjobs.com";
  static const String baseUrl = "https://my.bdjobs.com";
  static const String uploadVideoResumeAnswer = "/apps/mybdjobs/app_video_resume_upload_answer.asp";
  static const String uploadVideoResumeQuestionList = "/apps/mybdjobs/v1/app_video_resume_questionlist.asp";

  static const String userId = "4777518";
  static const String decodeId = "OTv6M6";

  static const int connectionTimeout = 5000;
  static const int receiveTimeout = 30000;
}

class ApiStatus {
  static const String dataFound = "0";
  static const String dbError = "1";
  static const String validation = "2";
  static const String noDataFound = "3";
  static const String crudSuccess = "4";

  static const int ok = 200;
}