
import 'package:flutter/material.dart';
 
void main() => runApp(SixthPage());
 
class SixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[700]
      ),
        home: Scaffold(
      appBar: AppBar(
        title: Text('Surprise'),
      ),
      body: Center(
          child: Image.network(
        'https://www.teamjimmyjoe.com/wp-content/uploads/2017/02/funny-Little-Kim-Jong-un.gif',
        width: 300,
        height: 400,
        fit: BoxFit.contain,
      )),
    ));
  }
}