
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/fifth_page.dart';
import 'Pages/first_page.dart';
import 'Pages/fourth_page.dart';
import 'Pages/second_page.dart';
import 'Pages/sixth_page.dart';
import 'Pages/third_page.dart';
import 'models/first_form_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirstFormModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
      initialRoute: '/5',
      routes: <String, WidgetBuilder> {
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
        '/4': (context) => FourthPage(),
        '/5': (context) => FifthPage(),
        '/6': (context) => SixthPage(),
      }
    );
  }
}

