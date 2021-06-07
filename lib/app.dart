import 'package:flutter/material.dart';
import 'package:hello_world/code.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'code.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CodeProvider>(
      create: (_) => CodeProvider(),
      child: MaterialApp(
        title: 'Lock App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: RequestPage(),
        home: HomePage(),
      ),
    );
  }
}
