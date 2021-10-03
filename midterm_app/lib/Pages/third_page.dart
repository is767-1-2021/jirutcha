import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Third Page'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.cloud)
              ),
              Tab(
                icon: Icon(Icons.beach_access_outlined),
              ),
              Tab(
                icon: Icon(Icons.brightness_1_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Cloud',
              style: TextStyle(height: 1, fontSize: 50),
              ), 
           ),
            Center(
              child: Text('Umbrella',
              style: TextStyle(height: 1, fontSize: 50),
              ),
            ),
            Center(
              child: Text('Sunny',
              style: TextStyle(height: 1, fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
