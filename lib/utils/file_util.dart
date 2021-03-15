import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {

  static final FileUtil instance = FileUtil._internal();

  String _filename;

  factory FileUtil(){
    return instance;
  }

  FileUtil._internal();

  Future<String> getFilePath() async {
    final Directory extDir = await getExternalStorageDirectory();
    print("Document directory : ${extDir.path}");
    final String dirPath = '${extDir.path}/Videos';
    await new Directory(dirPath).create(recursive: true);
    _filename = _timestamp();
    return '$dirPath/$_filename.webm';
  }

  String getFilename(){
    return _filename;
  }

  Future<File> getFile() async {
    return File(await getFilePath());
  }

  void saveFile(String filepath){
    try {
      File(filepath);
    } catch(e){
      print(e.toString());
    }
  }

  String _timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();
}