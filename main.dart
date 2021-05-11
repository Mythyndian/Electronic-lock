import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world/textWidgets.dart';
import 'package:hello_world/swiperWidget.dart';
import 'package:hello_world/codeInput.dart';
import 'package:code_field/code_field.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lock App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(187, 161, 156, 1),
        body: Stack(children: [
          Positioned(
            left: 165,
            top: 24,
            child: Center(
                child: TitleText(
              text: '3F',
            )),
          ),
          Positioned(
            child: SmallText(
              text: 'Three factor authentication solution',
            ),
            top: 100,
            left: 55,
          ),
          Positioned(
            child: SwiperWidget(),
            top: 200,
            left: 35,
            width: 325,
            height: 400,
          ),
          Positioned(
            child: Container(),
            top: 410,
          ),
          Positioned(
              top: 650,
              left: 140,
              child: Container(
                child: TextButton(
                  child: Text('Dismiss',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Puritan",
                          color: Color.fromRGBO(254, 254, 254, 1),
                          fontSize: 28,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  style: TextButton.styleFrom(
                      primary: Color.fromRGBO(106, 54, 42, 0.8),
                      onSurface: Colors.red),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputSequencePage(
                                titleText: 'Setup the sequence',
                                buttonLink: InputSequencePage(
                                  titleText: 'Repeat Sequence',
                                  buttonLink: ResultAlert(
                                    assetName: 'assets/icon/check.svg',
                                    title: 'Setup succes',
                                    buttonLink: ResultAlert(
                                      assetName: 'assets/icon/check.svg',
                                    ),
                                  ),
                                ),
                              )),
                    );
                  },
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(106, 54, 42, 0.83),
                    borderRadius: BorderRadius.circular(20)),
              ))
        ]));
  }
}
