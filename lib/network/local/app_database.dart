import 'dart:async';

import 'package:flutter_video/network/local/dao/media_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:flutter_video/network/local/entity/media.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [Media])
abstract class AppDatabase extends FloorDatabase {
  MediaDao get mediaDao;
}