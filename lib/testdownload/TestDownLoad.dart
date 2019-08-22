import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'file_util.dart';

class TestDownLoad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestDownLoadState();
  }
}

class TestDownLoadState extends State<TestDownLoad>with SingleTickerProviderStateMixin{

  GlobalKey globalKey = new GlobalKey();
  GlobalKey globalKey2 = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      home: new Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            MaterialButton(key:globalKey,onPressed: ()=>startDownload(),child: Text(button),),
//            MaterialButton(key:globalKey2,onPressed: ()=>startDownload(),child: Text("${(fadeAnimation.value*100).toInt()}"),),
            ],),
        ),
      ),
    );

    return app;
  }

  @override
  void initState() {
  }
  String button = "开始下载";

  Offset offset;
  startDownload() async {
    var url = "https://dmpcdn.ksmobile.com/cloud/334/O6QzWnjc0N_1552298403/jhYj36R99D_1553063692/P6DCkwRf3O4vM29g8uA1ziqwyDLC5ZRN_1553065184.mp3";
    File path = await FileUtil.getFile("example/test.MP3");
    var savePath = path.path;
    await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print("${(received / total * 100).floor()}%");
        setState(() {
          button = "${(received / total * 100).floor()}%";
          if((received / total * 100).toInt()==100){
            button="下载完成";
          }
        });
      }
    });
  }

  Future downloadWithChunks(
      url,
      savePath, {
        ProgressCallback onReceiveProgress,
      }) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    var progress = <int>[];

    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return _dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink= f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(
          response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

}

class ttt extends StatefulWidget {
  @override
  _tttState createState() => _tttState();
}

class _tttState extends State<ttt> {
  @override
  Widget build(BuildContext context) {
    return Text("hahhhhh");
  }
}

class Toast{
  static bool dismissed = false;
 static  OverlayEntry overlayEntry;
 static var overlay;
  static show(BuildContext context,Offset offset){
    overlay = Overlay.of(context);
    overlayEntry = new OverlayEntry(builder: (context){
      return buildlayout(offset);
    });
    _show();
  }
  static _show() async {
    overlay.insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: 3500));
    dismiss();
  }

  static dismiss() async {

    if (dismissed) {
      return;
    }
     dismissed = true;
    overlayEntry?.remove();
  }

  static LayoutBuilder buildlayout(Offset offset) {
    return LayoutBuilder(builder: (context,constraints){
      return IgnorePointer(
      ignoring:true ,
      child: Container(

        decoration: BoxDecoration(
          color :Color(0xffff0000),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text("hahhahahha",style: TextStyle(fontSize: 20),),),
      );
    },);
  }


}
