import 'package:exercise_app/old/models/food_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Record',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
      ),
      body: MyNoteForm(),
    );
  }
}

class MyNoteForm extends StatefulWidget {
  @override
  _MyNoteFormState createState() => _MyNoteFormState();
}

class _MyNoteFormState extends State<MyNoteForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _diets = [
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
  ];
  String _diet = 'Vegan';
  String? _meal;
  int _calories = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            width: 125.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
              color: Colors.lightGreen.withOpacity(0.50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: _decreaseCounter,
                        icon: Icon(Icons.remove),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text('$_counter',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 15.0)),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: _incrementCounter,
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your meal',
              icon: Icon(Icons.fastfood),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter meal.';
              }
              return null;
            },
            onSaved: (value) {
              _meal = value;
            },
            initialValue: context.read<FoodFormModel>().meal,
          ),
          DropdownButtonFormField(
            items: _diets.map((String priority) {
              return DropdownMenuItem(
                value: priority,
                child: Text(
                  priority,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18.0,
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Diet',
              labelStyle: TextStyle(fontSize: 18.0),
            ),
            onChanged: (value) {
              setState(() {
                _diet = value.toString();
              });
            },
            value: _diet,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Calories',
              icon: Icon(Icons.monitor_weight),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Calories.';
              }
              return null;
            },
            onSaved: (value) {
              _calories = int.parse(value!);
            },
            initialValue: context.read<FoodFormModel>().calories.toString(),
          ),
          Divider(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<FoodFormModel>().meal = _meal;
                      context.read<FoodFormModel>().calories = _calories;
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
