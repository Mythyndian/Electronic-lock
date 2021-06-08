import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world/input_sequence.dart';
import 'package:hello_world/request_list.dart';
import 'package:hello_world/result_alert.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'code.dart';

class AuthorizeAccess extends StatefulWidget {
  @override
  _AuthorizeAccessState createState() => _AuthorizeAccessState();
}

class _AuthorizeAccessState extends State<AuthorizeAccess> {
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
  final _channel = IOWebSocketChannel.connect('ws://192.168.0.46:80');

  bool codeIsCorrect = false;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    final CodeProvider codeProvider = Provider.of<CodeProvider>(context);
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
          buildNumberPad(codeProvider, codeIsCorrect),
          buildControlButtons(),
        ],
      ),
    );
  }

  void sendMessage(String msg) {
    _channel.sink.add(msg);
  }

  buildNumberPad(CodeProvider provider, bool flag) {
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
                      pinIndexSetup('1', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 2,
                    assetName: 'assets/icon/arrow-up.svg',
                    onPressed: () {
                      pinIndexSetup('2', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 3,
                    assetName: 'assets/icon/arrow-left.svg',
                    onPressed: () {
                      pinIndexSetup('3', provider);
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
                      pinIndexSetup('4', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 5,
                    assetName: 'assets/icon/arrow-right-down.svg',
                    onPressed: () {
                      pinIndexSetup('5', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 6,
                    assetName: 'assets/icon/arrow-left-down.svg',
                    onPressed: () {
                      pinIndexSetup('6', provider);
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
                      pinIndexSetup('7', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 8,
                    assetName: 'assets/icon/unlock.svg',
                    onPressed: () {
                      pinIndexSetup('8', provider);
                    },
                  ),
                  KeyboardNumber(
                    n: 9,
                    assetName: 'assets/icon/message.svg',
                    onPressed: () {
                      pinIndexSetup('9', provider);
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
                      pinIndexSetup('0', provider);
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

  pinIndexSetup(String text, CodeProvider provider) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) {
      if (provider.code == strPin) {
        this.codeIsCorrect = true;
        sendMessage('open');
      } else {}

      //print(this.codeIsCorrect);
    } // I need to call a method to save the PIN
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
            onPressed: () {
              if (this.codeIsCorrect) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultAlert(
                              assetName: 'assets/icon/check.svg',
                              title: 'Access Granted',
                              buttonLink: RequestPage(),
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultAlert(
                              assetName: 'assets/icon/close.svg',
                              title: 'Access Denied',
                              buttonLink: RequestPage(),
                            )));
              }
            },
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputSequence()));
            },
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
        ));
  }
}
