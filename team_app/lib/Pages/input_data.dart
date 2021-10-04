import 'package:team_app/models/first_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputData extends StatelessWidget{
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

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() {
    return _MyCustomFormState();
  }
}
class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
String? _date;
String? _workout;
int? _time;

  
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
            onSaved: (value) {
              _date = value;
            },
            initialValue: context.read<FirstFormModel>().date,
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
            onSaved: (value) {
              _workout = value;
            },
             initialValue: context.read<FirstFormModel>().workout,
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
            onSaved: (value) {
              _time = int.parse(value!);
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                context.read<FirstFormModel>().date = _date;
                context.read<FirstFormModel>().workout = _workout;
                context.read<FirstFormModel>().time = _time;
                Navigator.pushNamed(context,'/1' );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}