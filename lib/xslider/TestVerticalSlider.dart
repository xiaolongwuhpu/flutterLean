import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TestVerticalSlider()));

class TestVerticalSlider extends StatefulWidget {
  @override
  _TestVerticalSliderState createState() => _TestVerticalSliderState();
}

class _TestVerticalSliderState extends State<TestVerticalSlider> {
  double value = 6.0;
  ThemeData themeData;
  @override
  void initState() {
    super.initState();
  }

  Size size;

  @override
  Widget build(BuildContext context) {
//    themeData = Theme.of(context);
//     size =MediaQuery.of(context).size;
    return MaterialApp(
//      color: Colors.white70,
        home: Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            showD();
          },
          child: Text(
            "ceshi",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    ));
  }

  void showD() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
//         height: MediaQuery.of(context).size.height,
          height: 1700,
          child: Stack(
            children: <Widget>[
              Container(
                height: 25,
                width: double.infinity,
                color: Colors.black54,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: Center(child: Text("showModalBottomSheet")),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
