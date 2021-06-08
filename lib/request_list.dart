import 'package:flutter/material.dart';
import 'package:hello_world/authorize_access.dart';
import 'package:web_socket_channel/io.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _channel = IOWebSocketChannel.connect('ws://192.168.0.46:80');

  void sendMessage(String msg) {
    _channel.sink.add(msg);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Authorization requests',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.brown[200],
              Colors.brown[300],
            ],
            begin: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          sendMessage('?');
                          //codeProvider.disconnect();
                        })),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () {
                      sendMessage('close');
                    },
                  ),
                )
              ],
            ),
            StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return RequestAlert(
                                dataFromArduino:
                                    snapshot.hasData ? '${snapshot.data}' : '');
                          }));
                }),
          ],
        ),
        // child:
      ),
    );
  }
}

class RequestAlert extends StatefulWidget {
  //final DateTime date = new DateTime.now();
  final String dataFromArduino;
  RequestAlert({@required this.dataFromArduino});

  @override
  _RequestAlertState createState() => _RequestAlertState();
}

class _RequestAlertState extends State<RequestAlert> {
  String _status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.brown, borderRadius: BorderRadius.circular(10)),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthorizeAccess()),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Authorization required!',
                      style: TextStyle(color: Colors.white)),
                ),
                Text(
                  '${widget.dataFromArduino}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
