import 'package:flutter/material.dart';

import 'BMICalculatorScreen.dart';
import 'food_history_page.dart';
import 'menu_page.dart';

class Cat extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Cat> {
  List pages = ["https://google.com", "https://apple.com"];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Tips!"),
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            buildQuoteCard(),
            buildImageCard(),
            buildRoundedCard(),
            buildImageInteractionCard(),
            buildImageCard(),
            buildColoredCard(),
            buildImageCard(),
          ],
        ),
      );

  Widget buildQuoteCard() => Card(
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.orangeAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The only person you are destined to become is the person you decide to be.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ralph Waldo Emerson',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[100],
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildImageCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                'https://fitshop-production.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2020/11/20175150/Picture1-Makanan-bergizi-seimbang.png',
              ),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BMICalculatorScreen()));
                },
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Text(
                'Check Your BMI and BMR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                  fontSize: 26,
                ),
              ),
            ),
            /*Text(
              'Calculate your Basal Metabolic Rate and Body Mass Index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),*/
          ],
        ),
      );

  Widget buildRoundedCard() => Card(
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App on Diet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Calculate your Basal Metabolic Rate and Body Mass Index',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildImageInteractionCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                  ),
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    'Choose Your Menu!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Text(
                'A vast number of foods are both healthy and tasty. By filling your plate with fruits, vegetables, quality protein, and other whole foods, you’ll have meals that are colorful, versatile, and good for you.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: Text('Healthy Food'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuPage()));
                  },
                ),
                TextButton(
                  child: Text('Daily Meal Record'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FoodHistory()));
                  },
                )
              ],
            )
          ],
        ),
      );
  Widget buildColoredCard() => Card(
        shadowColor: Colors.red,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Don’t be afraid of trying something new.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'It’s easy to wonder which foods are healthiest.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      );
}

/*class ColorFilters {
  static final greyscale = ColorFilter.matrix(<double>[
    /// greyscale filter
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0
  ]);
}*/
