
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/home_page.dart';
import 'Pages/data_display.dart';
import 'Pages/exercise_history.dart';
import 'Pages/input_data.dart';
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
        '/1': (context) => DataDisplay(),
        '/2': (context) => InputData(),
        '/4': (context) => ExerciseHistory(),
        '/5': (context) => HomePage(),
      }
    );
  }
}

