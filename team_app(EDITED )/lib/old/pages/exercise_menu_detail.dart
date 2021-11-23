import 'package:exercise_app/old/pages/exercise_menu_page.dart';
import 'package:flutter/material.dart';

class ExerciseDetail extends StatelessWidget {
  final MenuItem item;

  const ExerciseDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Detail',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 25.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, '/2');  
        },
      ),  
      body: GestureDetector (
        onTap: (){
          Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) =>MovedMenu(item: this.item),
          ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300.0,
              width: 300.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreenAccent.withOpacity(0.50),
              ),
              child: item.menu     
            ),
            Container(
              padding: EdgeInsets.all(18.0),
              height: 60.0,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
              child: Text('${item.name}',
                  style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)), 
                  ), 
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child:
                Text('Calories burned: ${item.cal}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
                ),         
            ),
            Container(
              padding: EdgeInsets.all(25.0),
              child:
                Text(
                  " Exercise is fwun.",
                      ),
            ),   
          ],
        ),
     ),
   );  
  }
}

class MovedMenu extends StatelessWidget{
  final MenuItem item;
  const MovedMenu({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'Menu', 
            child: item.menu,
            ),
         ),
      ),
    );
  }
}