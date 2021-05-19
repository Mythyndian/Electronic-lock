import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSequence extends StatefulWidget {
  @override
  _InputSequenceState createState() => _InputSequenceState();
}

class _InputSequenceState extends State<InputSequence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.brown[200],
            Colors.brown[300],
            //Colors.deepPurple,
          ],
          begin: Alignment.topRight,
        )),
        child: OtpScreen(),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin = ['', '', '', ''];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment(0, 0.5),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSecurityText(),
                  SizedBox(
                    height: 40.0,
                  ),
                  buildPinRow(),
                ],
              ),
            ),
          ),
          buildNumberPad(),
          buildControlButtons(),
        ],
      ),
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 1,
                    assetName: 'assets/icon/arrow-down.svg',
                    onPressed: () {
                      pinIndexSetup('1');
                    },
                  ),
                  KeyboardNumber(
                    n: 2,
                    assetName: 'assets/icon/arrow-up.svg',
                    onPressed: () {
                      pinIndexSetup('2');
                    },
                  ),
                  KeyboardNumber(
                    n: 3,
                    assetName: 'assets/icon/arrow-left.svg',
                    onPressed: () {
                      pinIndexSetup('3');
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 4,
                    assetName: 'assets/icon/arrow-right-up.svg',
                    onPressed: () {
                      pinIndexSetup('4');
                    },
                  ),
                  KeyboardNumber(
                    n: 5,
                    assetName: 'assets/icon/arrow-right-down.svg',
                    onPressed: () {
                      pinIndexSetup('5');
                    },
                  ),
                  KeyboardNumber(
                    n: 6,
                    assetName: 'assets/icon/arrow-left-down.svg',
                    onPressed: () {
                      pinIndexSetup('6');
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 7,
                    assetName: 'assets/icon/arrow-left-up.svg',
                    onPressed: () {
                      pinIndexSetup('7');
                    },
                  ),
                  KeyboardNumber(
                    n: 8,
                    assetName: 'assets/icon/unlock.svg',
                    onPressed: () {
                      pinIndexSetup('8');
                    },
                  ),
                  KeyboardNumber(
                    n: 9,
                    assetName: 'assets/icon/message.svg',
                    onPressed: () {
                      pinIndexSetup('9');
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                    n: 0,
                    assetName: 'assets/icon/check.svg',
                    onPressed: () {
                      pinIndexSetup('0');
                    },
                  ),
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      height: 60.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: SvgPicture.asset(
                        'assets/icon/backspace.svg',
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) print(strPin);
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        )
      ],
    );
  }

  buildSecurityText() {
    return Text(
      'Security sequence',
      style: TextStyle(
          color: Colors.white70, fontSize: 21.0, fontWeight: FontWeight.bold),
    );
  }

  buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PINNumber({this.textEditingController, this.outlineInputBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.0,
        child: TextField(
          controller: textEditingController,
          enabled: false,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16.0),
              border: outlineInputBorder,
              filled: true,
              fillColor: Colors.white30),
        ));
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final String assetName;
  final Function() onPressed;
  KeyboardNumber({this.n, this.onPressed, this.assetName});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purpleAccent.withOpacity(0.1),
        ),
        alignment: Alignment.center,
        child: MaterialButton(
          color: Color.fromRGBO(106, 54, 42, 0.8),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          height: 90.0,
          child: SvgPicture.asset(
            this.assetName,
            color: Colors.white,
          ),
          // child: Text('$n',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 24,
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //     ))
        ));
  }
}
