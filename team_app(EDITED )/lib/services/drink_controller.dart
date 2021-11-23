import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/model/drink.dart';


class DrinkController {

  final firestoreInstance = FirebaseFirestore.instance;

  //Delivery Areas via CSV
  Future addAllDrinks(String drinkId, String drinkName, double totalkcal) async {
   try {   
      int kCal = (totalkcal * 1).toInt();
      dynamic result = await firestoreInstance.collection("Drinks").doc(drinkId).set({
        'drinkName': drinkName,
        'kCal': kCal,
        'totalCup' : 1,
        'totalkcal' : totalkcal
      }).then((doc) async {
        print("success!");
        return true;
      }).catchError((error) {
        print("Failed to add user: $error");
        return false;
      });

      if (result)
      {
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Status'] = "Success";
        return finalResponse;
      }
      else
      {
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] = "Cannot connect to server. Try again later";
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      return setUpFailure();
    }
  }

  Future getAllDrinks() async {
    List<Drink> drinkList = [];
    try {
      dynamic result = await firestoreInstance.collection("Drinks")
      .get().then((value) {
      value.docs.forEach((result) 
        {
          print(result.data);
          Map drinkData = result.data();
          drinkData['exerciseId'] = result.id;
          Drink drink = Drink(drinkData);
          drinkList.add(drink);
        });
        return true;
      });

      if (result)
      {
        drinkList.sort((a, b) => a.drinkName.toString().compareTo(b.drinkName.toString()));
        return  drinkList;
      }
      else
      {
        return  drinkList;
      }
    } catch (e) {
      print(e.toString());
      return drinkList;
    }
  }
  
  Map setUpFailure() {
    Map finalResponse = <dynamic, dynamic>{}; //empty map
    finalResponse['Status'] = "Error";
    finalResponse['ErrorMessage'] = "Please try again later. Server is busy.";
    return finalResponse;
  }
}
