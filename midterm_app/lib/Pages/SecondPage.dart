import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      floatingActionButton: FloatingActionButton(
       child: Icon(Icons.build_sharp), 
       onPressed: () {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Workout statistics'
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      child: Center(child: Text('No.')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                   
                    Container(
                      child: Center(child: Text('Date')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    
                    Container(
                      child: Center(child: Text('Exercise')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    
                    Container(
                      child: Center(child: Text('Duration')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    
                    Container(
                      child: Center(child: Text('Calories')),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    Text('1'),
                    Text('27/09/2021'),
                    Text('Boxing'),
                    Text('2h'),
                    Text('1000')
                  ],
                ),
                TableRow(
                  children: [
                    Text('2'),
                    Text('28/10/2021'),
                    Text('Cycling'),
                    Text('3h'),
                    Text('2000')
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
