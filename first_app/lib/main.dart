import 'package:first_app/pages/eighth_page.dart';
import 'package:first_app/pages/seventh_page.dart';
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
        '/7': (context) => SeventhPage(),
        '/8': (context) => EighthPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

 // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  
  Image cat = Image.asset(
  'assets/Image 1.png',
  width: 100,
  );
  
  Image cat1 = Image.asset(
  'assets/Image 2.png',
  width: 100,
  );

  Image cat2 = Image.asset(
    'assets/Image 1.png',
    width: 100,
  );

  void _incrementCounter() {
    setState(() {
      cat = cat2; 
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      cat = cat1; 
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
            height: 200.0,  
            margin: EdgeInsets.only(
              bottom: 20.0,
              right:100.0,
              left: 100.0
               ),
               padding: EdgeInsets.all(8.0),
               decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10.0),
               ),
               child: cat,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red
                  ),
                 onPressed: _decreaseCounter,
                 child: Text('Decrease')
              ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green
                  ),
                 onPressed: _incrementCounter,
                 child: Text('Increase'),
              ),
             ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
             ),
    );
  }
}

class submitButton extends StatelessWidget {
  final String buttonText;
  submitButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
   return ElevatedButton(
     child: Text(this.buttonText),
     onPressed: () {
      print('Pressing'); 
     },
   );
  }
}