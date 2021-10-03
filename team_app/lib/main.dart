import 'package:flutter/material.dart';

import 'Pages/MainPage.dart';
import 'Pages/FirstPage.dart';
import 'Pages/SecondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[700],
        primaryColor: Colors.grey[850],
        accentColor: Colors.tealAccent[400],
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.cyanAccent),
        ),
      ),
      initialRoute: '/1',
      routes: <String, WidgetBuilder> {
        '/1': (context) => MainPage(),
        '/2': (context) => FirstPage(),
        '/3': (context) => SecondPage(),
      }
    );
  }
}

