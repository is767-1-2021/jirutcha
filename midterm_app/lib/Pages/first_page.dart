import 'package:midterm_app/models/first_form_model.dart';
import 'package:midterm_app/pages/second_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: (){}, icon: Icon(Icons.agriculture)),
          IconButton(
            onPressed: (){
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => SecondPage(),
                ),
              );
            }, 
            icon: Icon(Icons.bus_alert)
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/3');
            }, 
            icon: Icon(Icons.medication)
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.food_bank)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Consumer<FirstFormModel>(
                builder: (context, form, child) {
                  return Text(
                  '${form.date} ${form.workout} ${form.time}');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/2');
              },
              child: Text('Fill this form please'),
            ),
          ],
        ),
      ),
    );
  }
}
