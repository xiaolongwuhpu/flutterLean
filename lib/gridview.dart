
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '假装是个标题'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  var  title ;
  _MyHomePageState(String title) {
    title = title;
  }
  _pushSaved(int index) {
//      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//        return new Scaffold(
//          body: new Text('我是 :'+index?.toString(),
//          ),
//        );
//      }));
    debugDumpApp();
    Fluttertoast.showToast(msg: '我是 $index' );
  }
  @override
  Widget build(BuildContext context) {


    List<Container> _buildGridTileList(int count) {
      return new List<Container>.generate(
          count,
          (int index) => new Container(
                child: new IconButton(
                  onPressed: _pushSaved(index),
                  icon: new Image.asset('image/p3.jpg',fit:BoxFit.fill,),
                ),
              ));
    }

    Widget _buildGrid() {
      return new GridView.extent(
          maxCrossAxisExtent: 150,
          padding: new EdgeInsets.all(4),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: _buildGridTileList(30));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildGrid(),
    );
  }
}
