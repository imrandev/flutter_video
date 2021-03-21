class Question {
  String slNo;
  String questionSerialNo;
  String questionId;
  String questionText;
  String questionTextBng;
  String questionDuration;
  String questionStatus;
  String videoUrl;
  String buttonStatus;
  String buttonName;
  String aID;
  String totalView;

  Question(
      {this.slNo,
        this.questionSerialNo,
        this.questionId,
        this.questionText,
        this.questionTextBng,
        this.questionDuration,
        this.questionStatus,
        this.videoUrl,
        this.buttonStatus,
        this.buttonName,
        this.aID,
        this.totalView});

  Question.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    questionSerialNo = json['questionSerialNo'];
    questionId = json['questionId'];
    questionText = json['questionText'];
    questionTextBng = json['questionTextBng'];
    questionDuration = json['questionDuration'];
    questionStatus = json['questionStatus'];
    videoUrl = json['videoUrl'];
    buttonStatus = json['buttonStatus'];
    buttonName = json['buttonName'];
    aID = json['aID'];
    totalView = json['totalView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['questionSerialNo'] = this.questionSerialNo;
    data['questionId'] = this.questionId;
    data['questionText'] = this.questionText;
    data['questionTextBng'] = this.questionTextBng;
    data['questionDuration'] = this.questionDuration;
    data['questionStatus'] = this.questionStatus;
    data['videoUrl'] = this.videoUrl;
    data['buttonStatus'] = this.buttonStatus;
    data['buttonName'] = this.buttonName;
    data['aID'] = this.aID;
    data['totalView'] = this.totalView;
    return data;
  }
}