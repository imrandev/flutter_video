import 'package:floor/floor.dart';
import 'package:flutter_video/network/local/entity/media.dart';

@dao
abstract class MediaDao {
  @Query('select * from Media')
  Future<List<Media>> findAll();

  @Query('SELECT * FROM Media WHERE id = :id')
  Stream<Media> findMediaById(int id);

  @insert
  Future<void> insertMedia(Media media);

  @Query('Select * from Media order by id desc limit 1')
  Future<Media> findLastMedia();
}
