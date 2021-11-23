import 'package:exercise_app/model/drink.dart';
import 'package:exercise_app/services/drink_controller.dart';
import 'package:exercise_app/utils/constants.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomDrink extends StatefulWidget {

  @override
  _AddCustomDrinkState createState() => _AddCustomDrinkState();
}

class _AddCustomDrinkState extends State<AddCustomDrink> {

  TextEditingController drinkName = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController cup = TextEditingController();
  TimeOfDay? timeUser;

  void saveDrink(){
    int totalCups =  int.parse(cup.text);
    Drink customDrink = Drink.fromEmpty();
    customDrink.drinkId = DateTime.now().millisecondsSinceEpoch.toString();
    customDrink.drinkName = drinkName.text; 
    customDrink.drinkKCalPerCup = int.parse(kcal.text);
    customDrink.totalCups = totalCups;
    customDrink.totalkcal = customDrink.drinkKCalPerCup/(1/customDrink.totalCups);
    customDrink.userCupSelected = int.parse(cup.text);
    customDrink.userBasedCalories = (customDrink.totalkcal).toInt();
    DrinkController().addAllDrinks(customDrink.drinkId,customDrink.drinkName,customDrink.totalkcal);
    Get.back(result: customDrink);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            
            Container(
              child: Center(
                child: Text(
                  'Add Custom Drink',
                  style :TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 2.3, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: drinkName,
                  decoration: new InputDecoration(
                    hintText: "Drink Name",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: kcal,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType : TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Calories",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                 child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: cup,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType : TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Cup",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                     ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
                      )
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(drinkName.text.isEmpty)
                          Constants.showDialog('Please enter exercise name');
                        else if(kcal.text.isEmpty)
                          Constants.showDialog('Please enter calories');
                        else if(cup.text.isEmpty)
                          Constants.showDialog('Please enter cup');
                        else
                        {
                          saveDrink();
                        }
                      },
                      child: Text(
                        'Save',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}