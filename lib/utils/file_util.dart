import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {

  static final FileUtil instance = FileUtil._internal();

  String _filename;

  factory FileUtil(){
    return instance;
  }

  FileUtil._internal();

  Future<String> getFilePath(String fileType) async {
    Directory directory;
    if (Platform.isIOS){
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }
    print("Document directory : ${directory.path}");
    final String dirPath = '${directory.path}/Videos';
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
    var file = File(filePath);
    if (await file.exists()){
      file.delete();
    }
    return file.exists();
  }

  String _timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();
}