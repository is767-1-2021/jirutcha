// import 'dart:html';

import 'package:flutter/material.dart';

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

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: (){}, icon: Icon(Icons.agriculture)),
          IconButton(onPressed: (){}, icon: Icon(Icons.bus_alert)),
          IconButton(onPressed: (){}, icon: Icon(Icons.medication)),
          IconButton(onPressed: (){}, icon: Icon(Icons.food_bank)),
        ],
      ),
    );
  }
} 

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      floatingActionButton: FloatingActionButton(
       child: Icon(Icons.build_sharp), 
       onPressed: () {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Here is the text formatted by theme data'
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      child: Center(child: Text('No.')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Name')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Container(
                      child: Center(child: Text('Gender')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    Text('1'),
                    Text('Jirutcha V.'),
                    Text('Female')
                  ]
                ),
                TableRow(
                  children: [
                    Text('2'),
                    Text('Butter'),
                    Text('Female')
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Third Page'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.cloud)
              ),
              Tab(
                icon: Icon(Icons.beach_access_outlined),
              ),
              Tab(
                icon: Icon(Icons.brightness_1_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Cloud',
              style: TextStyle(height: 1, fontSize: 50),
              ), 
           ),
            Center(
              child: Text('Umbrella',
              style: TextStyle(height: 1, fontSize: 50),
              ),
            ),
            Center(
              child: Text('Sunny',
              style: TextStyle(height: 1, fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Example'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color: Colors.cyan[colorCodes[index % 3]],
            child: Center(
              child: Text('Entry ${entries[index]}',
              style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}


class FifthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/${index+1}');
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Tap at $index'),
              // ));
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Page ${index+1}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SixthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Form'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your firstname',
              labelStyle: TextStyle(color: Colors.white)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter firstname.';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your lastname',
              labelStyle: TextStyle(color: Colors.white)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter lastname.';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your age',
              labelStyle: TextStyle(color: Colors.white)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter age.';
              }

              if (int.parse(value) < 18){
                return 'Please enter valid age.';
              }

              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Colplete'),
                ));
              }
            },
            child: Text('Validate'),
          ),
        ],
      ),
    );
  }
}