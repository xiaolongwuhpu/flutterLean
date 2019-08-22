import 'package:flutter/material.dart';
void main() => runApp(new MaterialApp(home: TestTabBar(),));
class TestTabBar extends StatefulWidget {
  @override
  _TestTabBarState createState() => _TestTabBarState();
}

class _TestTabBarState extends State<TestTabBar>
  with TickerProviderStateMixin {
  TabController _tabController; //定义tabcontroller变量
  static Container textChild(String text) =>  Container(height: 45,padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(8)),/*color: Colors.red,*/ border:Border.all() ) ,child: Text(text,style: TextStyle(
    color: Colors.white
  ),),);

  final List<Tab> myTabs = <Tab>[
    new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ), new Tab(
      child: textChild("朋友圈"),
    ),
  ];



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor:Colors.indigo,
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        bottom: new TabBar(
          controller: _tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.fromLTRB(9, 0, 9, 0),
          unselectedLabelStyle: TextStyle(fontSize: 14.0),
          labelStyle:TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight:0,
          indicator: BoxDecoration(/*backgroundBlendMode:BlendMode.src,*/gradient:LinearGradient(colors: [Colors.orangeAccent,Colors.red]),borderRadius:BorderRadius.all(Radius.circular(8)),/*color: Colors.red,*/ border:Border.all(color: Colors.white) ),
          unselectedLabelColor: Color(0x77FFFFFF),
          tabs:myTabs,
        ),
      ),
      body: new TabBarView(
        controller: _tabController, //tabbarView与 自定义的tabController绑定
        children: <Widget>[
          new Center(child: new Text('首页')),
          new Center(child: new Text('个人信息')),
          new Center(child: new Text('朋友圈')),
          new Center(child: new Text('朋友圈')),
          new Center(child: new Text('朋友圈')),
          new Center(child: new Text('朋友圈')),
          new Center(child: new Text('朋友圈')),
          new Center(child: new Text('朋友圈')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }
}
