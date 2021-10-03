import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(3, (index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/${index+1}');
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Tap at $index'),
              // ));
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Page ${index+1}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}




