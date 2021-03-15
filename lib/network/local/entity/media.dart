import 'package:floor/floor.dart';

@entity
class Media {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String playbackUrl;
  Media(this.id, this.title, this.playbackUrl);
}