
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  /// 读取指定文件的 json 数据
  static Future readAsString(String fileName) async {
    try {
      final file = await getFile(fileName);
      String str = await file.readAsString();
      return str;
    } catch (err) {
      print(err);
      return "";
    }
  }

  /// 写入 json 数据到指定文件
  static writeAsString(String fileName, obj) async {
    try {
      final file = await getFile(fileName);
//      return file.writeAsString(json.encode(obj));
      return file.writeAsString(obj);
    } catch (err) {
      print(err);
    }
  }
  /// 删除 指定文件
  static deleteFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      return file.deleteSync(recursive: false);
    } catch (err) {
      print(err);
    }
  }

  ///文件路径,默认是在 Ios的NSDocumentDirectory和Android上的 AppData目录
  static Future<File> getFile(String fileName) async {
    File file;
    try {
      final fileDirectory = await getApplicationDocumentsDirectory();
      //获取存储路径
      final filePath = fileDirectory.path;
      file = new File(filePath + "/" + fileName);
      bool isExist = await file.exists();
      if(!isExist){
         file.createSync(recursive: true);
      }
    } catch (e) {
      return  new File((await getApplicationDocumentsDirectory()).path + "/" + fileName);
    }
    return file;
  }

  ///文件的相对路径否存在,
  /// On iOS, this uses the `NSDocumentsDirectory` API.
  /// On Android, this returns the AppData directory.
  static Future<bool> isRelativeFileExists(String fileName) async {
    File file;
    try {
      final fileDirectory = await getApplicationDocumentsDirectory();
      //获取存储路径
      final filePath = fileDirectory.path;
      return isAbsoluteFileExists(filePath + "/" + fileName);
    } catch (e) {
      return  false;
    }
  }
  ///文件的绝对路径否存在
  static Future<bool> isAbsoluteFileExists(String absoluteFileName) async {
    if(absoluteFileName.length==0)return  false;
    File file;
    try {
      file = new File(absoluteFileName);
     return file.exists();
    } catch (e) {
      return  false;
    }
  }


//  static Future<bool> _isCurrVersion() async {
//    String saveVersion = await Preference().getVal("version", "0");
//    String currVersion = Env.packageInfo.version;
//    if (saveVersion != currVersion) {
//      Preference().setVal("version", currVersion);
//      return false;
//    } else {
//      return true;
//    }
//  }
}
