import 'package:exercise_app/old/models/first_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Workout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout record'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? _date;
  String? _workout;
  int? _time;
  int? _kcal;

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
                return 'kcal';
              }

              return null;
            },
            onSaved: (value) {
              _kcal = int.parse(value!);
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                context.read<FirstFormModel>().date = _date;
                context.read<FirstFormModel>().workout = _workout;
                context.read<FirstFormModel>().time = _time;
                context.read<FirstFormModel>().kcal = _kcal;

                Navigator.pop(context);
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
