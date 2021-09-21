import 'package:flutter/material.dart';

class SeventhPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faked Animated Pic'),
      ),
      body: GestureDetector(
        onTap: (){
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => MovedCat()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Hero(
              tag: 'Cat',
              child: Image.asset(
                'assets/image1.png',
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovedCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'Cat',
            child: Image.asset(
              'assets/image1.png',
              width: 120,
            ),
          ),
        ),
      ),
    );
  }
}