import 'package:exercise_app/old/models/food_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประเมิณความพึงพอใจ'),
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
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ความพึงพอใจจาก 1-5',
              icon: Icon(Icons.ring_volume),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Score.';
              }

              if (int.parse(value) > 5) {
                return 'Please enter valid Score.';
              }

              return null;
            },
            onSaved: (value) {
              _score = int.parse(value!);
            },
            initialValue: context.read<FoodFormModel>().score.toString(),
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<FoodFormModel>().score = _score;

                  Navigator.pop(context);
                }
              },
              child: Text('Validate'),
              style: TextButton.styleFrom(
                primary: Colors.orangeAccent,
                backgroundColor: Colors.green[900],
                onSurface: Colors.black12,
              )),
        ],
      ),
    );
  }
}
