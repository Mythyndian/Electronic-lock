import 'package:flutter/material.dart';

class SimpleTextButton extends StatelessWidget {
  final Widget buttonLink;
  final String buttonText;

  SimpleTextButton({@required this.buttonText, this.buttonLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text('$buttonText',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Puritan",
                color: Color.fromRGBO(254, 254, 254, 1),
                fontSize: 28,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500)),
        style: TextButton.styleFrom(
            primary: Color.fromRGBO(106, 54, 42, 0.8), onSurface: Colors.red),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => buttonLink),
          );
        },
      ),
      decoration: BoxDecoration(
          color: Color.fromRGBO(106, 54, 42, 0.83),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
