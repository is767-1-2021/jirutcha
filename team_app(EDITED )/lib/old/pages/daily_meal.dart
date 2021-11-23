import 'package:exercise_app/old/models/food_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Meal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Date&Time and Menu'),
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
  String? _time;
  String? _menu;
  int? _kCal;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter date',
              icon: Icon(Icons.event_note),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter date';
              }
              return null;
            },
            onSaved: (value) {
              _date = value;
            },
            initialValue: context.read<FoodFormModel>().date,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter time',
              icon: Icon(Icons.watch_later),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter time';
              }
              return null;
            },
            onSaved: (value) {
              _time = value;
            },
            initialValue: context.read<FoodFormModel>().time,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your menu',
              icon: Icon(Icons.local_restaurant),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter menu';
              }
              return null;
            },
            onSaved: (value) {
              _menu = value;
            },
            initialValue: context.read<FoodFormModel>().menu,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter kCal.',
              icon: Icon(Icons.calculate),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter kCal.';
              }
              if (int.parse(value) < 0) {
                return 'Plase enter kCal.';
              }
              return null;
            },
            onSaved: (value) {
              _kCal = int.parse(value!);
            },
            initialValue: context.read<FoodFormModel>().kCal.toString(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                context.read<FoodFormModel>().date = _date;
                context.read<FoodFormModel>().time = _time;
                context.read<FoodFormModel>().menu = _menu;
                context.read<FoodFormModel>().kCal = _kCal;

                Navigator.pop(context);
              }
            },
            child: Text('Validate'),
          ),
        ],
      ),
    );
  }
}
