import 'package:flutter/material.dart';

void main() => runApp(const FirstPage());

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Daily Exercise Record';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(192, 192, 192, 192),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          backgroundColor: Colors.grey[850],
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.cyanAccent)
          ),
        ),
        body: const MyCustomForm(),
      )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
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
              labelText: 'Enter Date (DD/MM/YYYY)',
              icon: Icon(Icons.date_range),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter date.';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Workout Activity (i.e.cycling, boxing...)',
              icon: Icon(Icons.fitness_center),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter work out activity';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(

              border: UnderlineInputBorder(),
              labelText: 'Duration (HH:MM)',
              icon: Icon(Icons.watch_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Time (HH:MM):';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Calories burnt (Cals)',
              icon: Icon(Icons.local_fire_department),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Fill in calories burnt';
              }

              return null;
            },
          ), 
          
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black,
              primary: Colors.tealAccent,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(context);
              }
            },
            child: Text('Done')  
          ),
        ],
      ),
    );
  }
}