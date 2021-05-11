import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world/textWidgets.dart';

class DisplayCode extends StatefulWidget {
  @override
  _DisplayCodeState createState() => _DisplayCodeState();
}

class _DisplayCodeState extends State<DisplayCode> {
  List<String> currentCode = ['', '', '', ''];
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row(
          children: [
            Container(
                width: 45,
                margin: EdgeInsets.all(15),
                height: 45,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(102, 53, 53, 0.38))),
            Container(
                margin: EdgeInsets.all(15),
                width: 45,
                height: 45,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(102, 53, 53, 0.38))),
            Container(
                margin: EdgeInsets.all(15),
                width: 45,
                height: 45,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(102, 53, 53, 0.38))),
            Container(
                margin: EdgeInsets.all(15),
                width: 45,
                height: 45,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(102, 53, 53, 0.38)))
          ],
        ),
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  final String assetName;
  final VoidCallback onPressUpdate;
  GridButton({@required this.assetName, this.onPressUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        height: 65,
        margin: EdgeInsets.all(15),
        child: IconButton(
          icon: SvgPicture.asset(
            '$assetName',
            color: Color.fromRGBO(249, 204, 204, 0.41),
          ),
          color: Color.fromRGBO(249, 204, 204, 0.41),
          onPressed: () { /*Tell dispay code I was clicked and send something to it*/},
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(106, 54, 42, 0.83),
            borderRadius: BorderRadius.circular(20)));
  }
}

class ResultAlert extends StatelessWidget {
  final String assetName;
  final String title;
  final Widget buttonLink;
  ResultAlert({@required this.assetName, this.title, this.buttonLink});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(187, 161, 156, 1),
      body: Stack(
        children: [
          Positioned(
              top: 24,
              left: 85,
              child: SafeArea(
                child: Center(
                  child: TitleText(
                    text: '$title',
                  ),
                ),
              )),
          Positioned(
              top: 200,
              left: 50,
              child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(106, 54, 42, 0.83),
                      borderRadius: BorderRadius.circular(20)))),
          Positioned(
              width: 300,
              height: 400,
              top: 200,
              left: 50,
              child: SvgPicture.asset(
                '$assetName',
                color: Color.fromRGBO(249, 204, 204, 0.41),
              )),
          Positioned(
              top: 650,
              left: 140,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(106, 54, 42, 0.83),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: Text('Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Puritan",
                          color: Color.fromRGBO(254, 254, 254, 1),
                          fontSize: 28,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => this.buttonLink),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}

class InputSequencePage extends StatefulWidget {
  final String titleText;
  final Widget buttonLink;
  InputSequencePage({@required this.titleText, this.buttonLink});

  @override
  _InputSequencePageState createState() => _InputSequencePageState();
}

class _InputSequencePageState extends State<InputSequencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(187, 161, 156, 1),
      body: Stack(
        children: [
          Positioned(
              top: 24,
              left: 30,
              child: TitleText(
                text: '${widget.titleText}',
              )),
          Positioned(top: 100, left: 45, child: DisplayCode()),
          Positioned(
              top: 300,
              left: 45,
              child: Row(
                children: [
                  GridButton(assetName: 'assets/icon/arrow-up.svg'),
                  GridButton(assetName: 'assets/icon/arrow-down.svg'),
                  GridButton(assetName: 'assets/icon/arrow-left.svg'),
                ],
              )),
          Positioned(
              top: 400,
              left: 45,
              child: Row(
                children: [
                  GridButton(assetName: 'assets/icon/arrow-right.svg'),
                  GridButton(assetName: 'assets/icon/arrow-left-up.svg'),
                  GridButton(assetName: 'assets/icon/arrow-left-down.svg'),
                ],
              )),
          Positioned(
              top: 500,
              left: 45,
              child: Row(
                children: [
                  GridButton(assetName: 'assets/icon/arrow-right-up.svg'),
                  GridButton(assetName: 'assets/icon/arrow-right-down.svg'),
                  GridButton(assetName: 'assets/icon/backspace.svg')
                ],
              )),
          Positioned(
              top: 640,
              left: 120,
              child: SafeArea(
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icon/check.svg',
                    color: Color.fromRGBO(153, 153, 153, 1),
                    width: 80,
                    height: 70,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => this.widget.buttonLink,
                        ));
                  },
                ),
              )),
          Positioned(
              top: 640,
              left: 225,
              child: SafeArea(
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icon/close.svg',
                    color: Color.fromRGBO(153, 153, 153, 1),
                    width: 80,
                    height: 70,
                  ),
                  onPressed: () {},
                ),
              )),
        ],
      ),
    );
  }
}
