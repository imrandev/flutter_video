import 'package:flutter_video/model/video.dart';
import 'package:flutter_video/network/local/dao/media_dao.dart';
import 'package:flutter_video/network/local/entity/media.dart';
import 'package:flutter_video/utils/file_util.dart';

abstract class BaseRepository<T, P> {
  Future<int> add(P args);
  Future<List<T>> get();
  Future<bool> delete(T args);
}

class VideoRepository extends BaseRepository<Media, Video> {

  final MediaDao mediaDao;

  VideoRepository(this.mediaDao);

  @override
  Future<int> add(Video video) async {
    int id = 1;
    mediaDao.findLastMedia().then((media) async {
      if (media != null) {
        id = media.id + 1;
      }
      final newMedia = Media(id, video.title, video.playbackUrl, video.fileType);
      await mediaDao.insertMedia(newMedia);
    });
    return id;
  }

  @override
  Future<List<Media>> get() async {
    return await mediaDao.findAll();
  }

  @override
  Future<bool> delete(Media args) async {
    if (!await FileUtil().delete(args.playbackUrl)) {
      await mediaDao.deleteMedia(args);
      return true;
    }
    return false;
  }
}