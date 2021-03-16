class UploadResponse {

  String statuscode;
  String message;

  UploadResponse({this.statuscode, this.message,});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    return data;
  }
}