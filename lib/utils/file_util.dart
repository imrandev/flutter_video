import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {

  static final FileUtil instance = FileUtil._internal();

  String _filename;

  factory FileUtil(){
    return instance;
  }

  FileUtil._internal();

  Future<String> getFilePath(String fileType) async {
    final Directory extDir = await getExternalStorageDirectory();
    print("Document directory : ${extDir.path}");
    final String dirPath = '${extDir.path}/Videos';
    await new Directory(dirPath).create(recursive: true);
    _filename = _timestamp();
    return '$dirPath/$_filename.$fileType';
  }

  String getFilename(){
    return _filename;
  }

  Future<File> getFile(String fileType) async {
    return File(await getFilePath(fileType));
  }

  Future<File> copyFile(String oldPath, String newPath){
    return File(oldPath).copy(newPath);
  }

  Future<bool> delete(String filePath) async{
    var entity = await File(filePath).delete();
    return entity.exists();
  }

  String _timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<File> getImageFile() async {
    final filename = 'play.png';
    var bytes = await rootBundle.load("assets/play.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes,'$dir/$filename');
    File file = new File('$dir/$filename');
    return file;
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}