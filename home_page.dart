import 'package:flutter/material.dart';
import 'package:hello_world/input_sequence.dart';
import 'text_widgets.dart';
import 'swiper_widget.dart';
import 'simple_text_button.dart';

class HomePage extends StatelessWidget {
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
          children: [
            SafeArea(
                child: Center(
                    child: TitleText(
              text: '3F',
            ))),
            SmallText(text: 'Three factor authentication solution'),
            Padding(
              padding: EdgeInsets.only(top: 64.0, bottom: 32.0),
              child: Container(
                child: SwiperWidget(),
                width: 325,
                height: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SimpleTextButton(
                  buttonText: 'Dismiss', buttonLink: InputSequence()),
            )
          ],
        ),
      ),
    );
  }
}
