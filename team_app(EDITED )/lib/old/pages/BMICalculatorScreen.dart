import 'package:flutter/material.dart';
import 'BMIModel.dart';
import 'ResultFemale.dart';
import 'Resultmale.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _heightOfUser = 160.0;
  double _weightOfUser = 50.0;
  double _bmi = 0;
  double _bmrf = 0;
  double _bmrm = 0;
  int _age = 0;
  late BMIModel _bmiModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Image.asset(
                  "assets/images/popcat1.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "BMI Calculator",
                style: TextStyle(
                    color: Colors.pink[400],
                    fontSize: 34,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Pop Pop your BMI",
                style: TextStyle(
                    color: Colors.brown[300],
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Height (cm)",
                style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 0.0,
                  max: 250.0,
                  onChanged: (height) {
                    setState(() {
                      _heightOfUser = height;
                    });
                  },
                  value: _heightOfUser,
                  divisions: 100,
                  activeColor: Colors.pink[400],
                  label: "$_heightOfUser",
                ),
              ),
              Text(
                "$_heightOfUser cm",
                style: TextStyle(
                    color: Colors.orange[300],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Weight (kg)",
                style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 0.0,
                  max: 250.0,
                  onChanged: (height) {
                    setState(() {
                      _weightOfUser = height;
                    });
                  },
                  value: _weightOfUser,
                  divisions: 100,
                  activeColor: Colors.pink[400],
                  label: "$_weightOfUser",
                ),
              ),
              Text(
                "$_weightOfUser kg",
                style: TextStyle(
                    color: Colors.orange[300],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Age",
                style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _age++;
                          });
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _age--;
                          });
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.remove),
                      ),
                    ]),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$_age years old",
                style: TextStyle(
                    color: Colors.orange[300],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _bmi = _weightOfUser /
                            ((_heightOfUser / 100) * (_heightOfUser / 100));
                        _bmrf = 9.99 * _weightOfUser +
                            6.25 * _heightOfUser -
                            4.92 * _age -
                            161;

                        if (_bmi >= 18.5 && _bmi <= 25) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: true,
                              isUnder: false,
                              isOver: false,
                              comments: "Your BMI is Normal");
                        } else if (_bmi < 18.5) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: true,
                              isOver: false,
                              comments: "You are Underweighted");
                        } else if (_bmi > 25 && _bmi <= 30) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: false,
                              isOver: true,
                              comments: "You are Overweighted");
                        } else {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: false,
                              isOver: false,
                              comments: "You are Obesed");
                        }
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultFemale(
                                    bmiModel: _bmiModel,
                                    bmrModel: _bmrf,
                                  )));
                    },
                    icon: Icon(
                      Icons.female,
                      color: Colors.pink[100],
                    ),
                    label: Text("CALCULATE"),
                    style: TextButton.styleFrom(
                      primary: Colors.purple[100],
                      backgroundColor: Colors.pink,
                      onSurface: Colors.brown,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _bmi = _weightOfUser /
                            ((_heightOfUser / 100) * (_heightOfUser / 100));

                        _bmrm = 9.99 * _weightOfUser +
                            6.25 * _heightOfUser -
                            4.92 * _age +
                            5;

                        if (_bmi >= 18.5 && _bmi <= 25) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: true,
                              isUnder: false,
                              isOver: false,
                              comments: "Your BMI is Normal");
                        } else if (_bmi < 18.5) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: true,
                              isOver: false,
                              comments: "You are Underweighted");
                        } else if (_bmi > 25 && _bmi <= 30) {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: false,
                              isOver: true,
                              comments: "You are Overweighted");
                        } else {
                          _bmiModel = BMIModel(
                              bmi: _bmi,
                              bmrf: _bmrf,
                              bmrm: _bmrm,
                              isNormal: false,
                              isUnder: false,
                              isOver: false,
                              comments: "You are Obesed");
                        }
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultMale(
                                    bmiModel: _bmiModel,
                                    bmrModel: _bmrm,
                                  )));
                    },
                    icon: Icon(
                      Icons.male,
                      color: Colors.green[100],
                    ),
                    label: Text("CALCULATE"),
                    style: TextButton.styleFrom(
                        primary: Colors.purple[100],
                        backgroundColor: Colors.green,
                        onSurface: Colors.brown)),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.pink,
                    ),
                    label: Text("Back"),
                    style: TextButton.styleFrom(
                      primary: Colors.orangeAccent,
                      backgroundColor: Colors.black12,
                      onSurface: Colors.black12,
                    )),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
