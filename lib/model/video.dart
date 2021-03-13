class Video {
  int id;
  String title;
  String playbackUrl;
  String image;

  Video({this.id, this.title, this.playbackUrl, this.image});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    playbackUrl = json['playback_url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['playback_url'] = this.playbackUrl;
    data['image'] = this.image;
    return data;
  }
}