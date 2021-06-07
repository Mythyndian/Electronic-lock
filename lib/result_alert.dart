import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_world/simple_text_button.dart';
import 'package:hello_world/text_widgets.dart';

class ResultAlert extends StatelessWidget {
  final String assetName;
  final String title;
  final Widget buttonLink;
  ResultAlert({@required this.assetName, this.title, this.buttonLink});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.brown[200],
          Colors.brown[300],
        ],
        begin: Alignment.topRight,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SafeArea(
            child: Center(
              child: TitleText(
                text: '$title',
              ),
            ),
          ),
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              color: Color.fromRGBO(106, 54, 42, 0.83),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 400,
                  child: SvgPicture.asset(
                    '$assetName',
                    color: Color.fromRGBO(249, 204, 204, 0.41),
                  ),
                ),
              ],
            ),
          ),
          SimpleTextButton(
            buttonText: 'Continue',
            buttonLink: buttonLink,
          )
        ],
      ),
    ));
  }
}
