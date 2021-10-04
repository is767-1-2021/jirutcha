import 'package:flutter/material.dart';
import 'package:midterm_app/Pages/exercise_history.dart';
import 'package:midterm_app/Pages/input_data.dart';
import 'package:midterm_app/Pages/data_display.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return new Stack(
      children: <Widget>[
        new Container(
          color: Colors.grey[700],
        ),
        new Scaffold(
          appBar: AppBar(
            title: Text("Welcome"),
            centerTitle: true,
          ),
        drawer: HomePage(),
          backgroundColor: Colors.transparent,
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Divider(
                      height: _height / 20,
                      color: Colors.cyanAccent,
                    ),
                  ],
                ),
                Expanded(
                    child: Center(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: <Widget>[
                                            
                      homePageRowCell(Icons.account_circle, "Input Data",
                          context, InputData()),
                      
                      homePageRowCell(
                          Icons.account_box, "Data Display", context, DataDisplay()),
                      
                      homePageRowCell(
                          Icons.assessment, "History", context, ExerciseHistory()),
                      
                      homePageRowCell(
                          Icons.dashboard, "Home page", context, HomePage()),
                                            


                    ],
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }

Widget homePageRowCell(
        var sIcon, String title, BuildContext context, var page) =>
    new Container(
        child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              new Icon(
                sIcon,
                size: 40,
                color: Colors.cyanAccent,
              ),
              new Text(title,
                  style: new TextStyle(
                    fontSize: 20,
                    color: Colors.black, fontWeight: FontWeight.normal)),
            ],
          ),
        ],
      ),
    )
  );
}