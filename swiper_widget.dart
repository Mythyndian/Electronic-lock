import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/text_widgets.dart';

class SwiperWidget extends StatefulWidget {
  @override
  _SwiperWidgetState createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  final List<Widget> steps = [
    SwiperState(
      assetName: 'assets/icon/unlock.svg',
      heading: 'Welcome',
      smallHeading: "It's time for little introduction",
      headingOffset: 90,
    ),
    SwiperState(
      assetName: 'assets/icon/message.svg',
      heading: 'How it works',
      smallHeading:
          "After entering the the lock code\nyou will  be asked to prompt\nsafety sequence",
      headingOffset: 65,
    ),
    SwiperState(
      assetName: 'assets/icon/check.svg',
      heading: "That's all you need",
      smallHeading: "Let's setup safe sequence",
      headingOffset: 5,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return steps[index];
        },
        itemCount: 3,
        itemWidth: 300,
        pagination: new SwiperPagination());
  }
}

class SwiperState extends StatelessWidget {
  final String assetName, heading, smallHeading;
  final double headingOffset;
  SwiperState(
      {@required this.assetName,
      this.heading,
      this.smallHeading,
      this.headingOffset});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(106, 54, 42, 0.83),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
                width: 125,
                height: 250,
                child: SvgPicture.asset(
                  '$assetName',
                  color: Color.fromRGBO(249, 204, 204, 0.41),
                )),
            HeadingText(text: "$heading"),
            SmallHeadingText(text: "$smallHeading"),
          ],
        ));
  }
}
