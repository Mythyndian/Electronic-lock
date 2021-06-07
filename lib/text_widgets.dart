import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  TitleText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text('$text',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(124, 58, 58, 1),
                fontFamily: "Puritan",
                fontSize: 40,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700)));
  }
}

class SmallText extends StatelessWidget {
  final String text;
  SmallText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text("Three factor authentication solution",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(102, 53, 53, 0.38),
                fontFamily: "Puritan",
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700)));
  }
}

class HeadingText extends StatelessWidget {
  final String text;
  HeadingText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: "Puritan",
          color: Color.fromRGBO(254, 254, 254, 1),
          fontSize: 40,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700),
    );
  }
}

class SmallHeadingText extends StatelessWidget {
  final String text;
  SmallHeadingText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Wrap(direction: Axis.vertical, children: [
      Text(
        '$text',
        textAlign: TextAlign.center,
        maxLines: 3,
        style: TextStyle(
            color: Color.fromRGBO(217, 205, 205, 0.44),
            fontFamily: "Puritan",
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700),
      )
    ]);
  }
}