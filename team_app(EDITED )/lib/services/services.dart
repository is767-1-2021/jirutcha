/*import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/model/drink.dart';



abstract class Services {
  Future<List<Drink>> getDrinks(String drinks);
  
}

class FirebaseServices extends Services {
  CollectionReference _ref =
      FirebaseFirestore.instance.collection('drinks');

  @override
  Future<List<Drink>> getDrinks(String drinkName) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('drinks')
        .where('drinkName', isEqualTo: drinkName)
        .where('isActive', isEqualTo: true)
        .orderBy('drinks', descending: false)
        .get();

    AllDrinks drinks = AllDrinks.fromSnapshot(snapshot);
    return drinks.drinks;
  }
}*/