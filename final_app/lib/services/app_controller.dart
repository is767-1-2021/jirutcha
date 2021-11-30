import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppController {

  final firestoreInstance = FirebaseFirestore.instance;

  Future addExpenseNameInFirebase(String expenseName) async {
    try {   
      dynamic result = await firestoreInstance.collection("ExpenseName").add({
        'name': expenseName,
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

  Future getAllExpensesNames() async {
    List<String> expenseNames = [];
    try {
      dynamic result = await firestoreInstance.collection("ExpenseName").get().then((value) {
      value.docs.forEach((result) 
        {
          print(result.data);
          expenseNames.add(result.data()['name'].toString());
        });
        return true;
      });

      if (result)
      {
        return expenseNames;
      }
      else
      {
        return expenseNames;
      }
    } catch (e) {
      print(e.toString());
      return expenseNames;
    }
  }

  Future getAllExpenseImages() async {
    List expenseImageList = [];
    try {
      dynamic result = await firestoreInstance.collection("ExpensesImages").get().then((value) {
      value.docs.forEach((result) 
        {
          print(result.data);
          expenseImageList = result.data()['imageList'];
        });
        return true;
      });

      if (result)
      {
        return expenseImageList;
      }
      else
      {
        return expenseImageList;
      }
    } catch (e) {
      print(e.toString());
      return expenseImageList;
    }
  }
  
  Map setUpFailure() {
    Map finalResponse = <dynamic, dynamic>{}; //empty map
    finalResponse['Status'] = "Error";
    finalResponse['ErrorMessage'] = "Please try again later. Server is busy.";
    return finalResponse;
  }
}
