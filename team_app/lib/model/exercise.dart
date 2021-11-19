import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Exercise{

  String exerciseId = '';
  String exerciseName = "";
  int exerciseKCalPerHour = 0;
  int totalTimeInMinutes = 0;
  int totalTimeInHours = 0;
  double caloriesPerMinute = 0;
  int userTimeMinutesSelected = 0;
  String userTimeSelected = '';
  int userTimeBasedCalories = 0;

  Exercise(Map data)
  {
    exerciseId = data["exerciseId"];
    exerciseName = data["exerciseName"];
    totalTimeInMinutes = data['totalTime'];
    totalTimeInHours = (data['totalTime']/60).toInt();
    exerciseKCalPerHour =  data["kcal"];
    caloriesPerMinute =  data["timePerMinute"];
  }

  Exercise.fromEmpty(); 

  Map<String, dynamic> toJson() {
    return {
      "exerciseId": this.exerciseId,
      "exerciseName": this.exerciseName,
      "totalTimeInMinutes": this.totalTimeInMinutes,    
      "totalTimeInHours": this.totalTimeInHours,    
      "exerciseKCalPerHour": this.exerciseKCalPerHour,    
      "caloriesPerMinute": this.caloriesPerMinute,  
      "userTimeMinutesSelected": this.userTimeMinutesSelected,  
      "userTimeSelected": this.userTimeSelected,  
      "userTimeBasedCalories": this.userTimeBasedCalories,  
    };
  }

  Exercise.fromSavedJson(Map<String, dynamic> data) {
    exerciseId = data["exerciseId"];
    exerciseName = data["exerciseName"];
    totalTimeInMinutes = data['totalTimeInMinutes'];
    totalTimeInHours = data['totalTimeInHours'];
    exerciseKCalPerHour =  data["exerciseKCalPerHour"];
    caloriesPerMinute =  data["caloriesPerMinute"];
    userTimeMinutesSelected =  data["userTimeMinutesSelected"];
    userTimeSelected =  data["userTimeSelected"];
    userTimeBasedCalories =  data["userTimeBasedCalories"];
  }

  static Future<void> saveExercisesForDate(DateTime dateTime, List<Exercise> exerciseList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savingList = [];
    for(int i =0; i < exerciseList.length; i ++)
    {
      Map<String, dynamic> json = exerciseList[i].toJson();
      String newAddition = jsonEncode(Exercise.fromSavedJson(json));
      savingList.add(newAddition);
    }
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    await prefs.setStringList(dateTimeKey, savingList);
  }

  static Future getSavedExercisesForDate(DateTime dateTime) async {
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    List<Exercise> savedListForDate = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('$dateTimeKey') ?? [];
    for(int i=0; i < alreadySaved.length; i++)
    {
      Map<String, dynamic> decodeList = jsonDecode(alreadySaved[i]);
      Exercise exercise = Exercise.fromSavedJson(decodeList);
      savedListForDate.add(exercise);
    }
    return savedListForDate;
  }
}