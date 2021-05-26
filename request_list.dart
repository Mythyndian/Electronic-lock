import 'package:flutter/material.dart';
import 'package:hello_world/authorize_access.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Authorization requests',
          style: TextStyle(color: Colors.white),
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
        child: ListView(
          children: [RequestAlert()],
        ),
      ),
    );
  }

  startServer() {
     ServerSocket.bind(InternetAddress.anyIPV4, 4567).then(
    (ServerSocket server) {
      server.listen(handleClient);
    }
  );
  }

    handleClient(Socket client) {
      
  }
}

class RequestAlert extends StatelessWidget {
  //final DateTime date = new DateTime.now();
  final String dataFromArduino;
  final String formatedDate =
      DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
  RequestAlert({@required this.dataFromArduino});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: 100,
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
                  '$formatedDate',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
