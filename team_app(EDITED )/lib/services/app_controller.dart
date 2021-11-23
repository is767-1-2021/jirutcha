import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/model/exercise.dart';

class AppController {

  final firestoreInstance = FirebaseFirestore.instance;
  Future addExercise(String exerciseId, String exerciseName, double caloriesPerMinute) async {
    try {   
      int caloriesPrHour = (caloriesPerMinute * 60).toInt();
      dynamic result = await firestoreInstance.collection("exercise_menu").doc(exerciseId).set({
        'exerciseName': exerciseName,
        'kcal': caloriesPrHour,
        'totalTime' : 60,
        'timePerMinute' : caloriesPerMinute
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

  Future getAllExercises() async {
    List<Exercise> exerciseList = [];
    try {
      dynamic result = await firestoreInstance.collection("exercise_menu")
      .get().then((value) {
      value.docs.forEach((result) 
        {
          print(result.data);
          Map exerciseData = result.data();
          exerciseData['exerciseId'] = result.id;
          Exercise exercise = Exercise(exerciseData);
          exerciseList.add(exercise);
        });
        return true;
      });

      if (result)
      {
        exerciseList.sort((a, b) => a.exerciseName.toString().compareTo(b.exerciseName.toString()));
        return exerciseList;
      }
      else
      {
        return exerciseList;
      }
    } catch (e) {
      print(e.toString());
      return exerciseList;
    }
  }
  
  Map setUpFailure() {
    Map finalResponse = <dynamic, dynamic>{}; //empty map
    finalResponse['Status'] = "Error";
    finalResponse['ErrorMessage'] = "Please try again later. Server is busy.";
    return finalResponse;
  }
}

