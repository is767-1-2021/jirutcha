import 'package:exercise_app/old/pages/exercise_menu_page.dart';
import 'package:exercise_app/old/pages/menu_page.dart';
import 'package:exercise_app/old/pages/webview.dart';
import 'package:exercise_app/screens/home/drinkpage.dart';
import 'package:exercise_app/screens/home/foodpage.dart';
import 'package:exercise_app/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'old/pages/BMICalculatorScreen.dart';
import 'old/pages/Home_menu.dart';
import 'old/pages/daily_meal.dart';
import 'old/pages/score_result.dart';
import 'old/pages/welcome.dart';
import 'old/pages/workout.dart';
import 'old/pages/workout_result.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primaryColor: Color (0xFFC3DEB6),          //Appbar
        scaffoldBackgroundColor: Color (0xFFFFFFFF)//Background
      ),
      home: MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}
 
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("On Diet",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
      centerTitle: true,),
      body: ListView(
      scrollDirection: Axis.vertical,
      children: [

            // Individual Button Proflie
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFFF0EB),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/woman.png"),                                               //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Profile",                                                                  //---TITLE---
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => BMICalculatorScreen()),                                                 //---LINK---
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
           // ---END OF TAB

            // Individual Button 1
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAF9F0),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/bmi.png"),                                               //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("BMI Calculator",                                                                  //---TITLE---
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => BMICalculatorScreen()),                                                 //---LINK---
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
           // ---END OF TAB

           // Individual Button 2
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAE7E3),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/cocktail.png"),                                               //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Drink Diary",                                                                    //---TITLE---
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => DrinkPage()),                                                            //---LINK---
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 3
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFF7D9D7),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/meal.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Food Diary",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => FoodPage()),                                                                      //---LINK--- 
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 4
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAF9F0),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/runner.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Workout Diary",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => HomeScreen()),                                                                      //---LINK--- 
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 5
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAE7E3),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/diet (1).png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => MyHomePage()),                                                                      //---LINK--- NEED DESTINATION
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 6
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFF7D9D7),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/menu.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Food & Drink Menu",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => MenuPage()),                                                                      //---LINK--- 
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 7
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAF9F0),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/routine.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Workout Menu",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => ExerciseMenu()),                                                                      //---LINK--- NEED DESTINATION
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 8
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFFAE7E3),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/newspaper.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("News",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => WebViewExample()),                                                                      //---LINK--- 
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB

          // Individual Button 9
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Color (0xFFF7D9D7),
              borderRadius: BorderRadius.circular(8.0),),
              height: 100,
              child: Row(
              children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
              child:Image.asset("assets/images/weightlifting.png"),                                                           //---IMAGE---
              flex:2 ,
                    ),
                  ),
                ),
            Expanded(
              child:Container(
              alignment: Alignment.topLeft,
              child: Column(
              children: [
            Expanded(
              flex: 5,
              child: ListTile(
              title: Text("Tips",
              textAlign: TextAlign.center,
              style: TextStyle(height: 3.4, fontSize: 20, fontWeight: FontWeight.bold, color: Color (0xFF957DAD)),),                              //---TITLE---
              onTap: (){
             Navigator.push(context,
            MaterialPageRoute(
    	        builder: (context) => WebViewExample()),                                                                      //---LINK--- 
                            );
                           }
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex:8 ,
                ),
              ],
            ),
          ),
          // ---END OF TAB
        ]
       )
      );
    }
  }


