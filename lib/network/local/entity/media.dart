import 'package:floor/floor.dart';

@entity
class Media {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String playbackUrl;
  final String fileType;

  Media(this.id, this.title, this.playbackUrl, this.fileType);
}