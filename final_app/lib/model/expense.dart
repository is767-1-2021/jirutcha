import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Expense{

  String expenseId = '';
  String expenseName = "";
  double postiveExpenseTotal = 0;
  double negativeExpenseTotal = 0;
  String expenseImage = '';

  Expense(Map data)
  {
    expenseId = data["expenseId"];
    expenseName = data["expenseName"];
    postiveExpenseTotal = data['postiveExpenseTotal'];
    negativeExpenseTotal = data['negativeExpenseTotal'];
    expenseImage =  data["expenseImage"];
  }

  Expense.fromEmpty(); 

  Map<String, dynamic> toJson() {
    return {
      "expenseId": this.expenseId,
      "expenseName": this.expenseName,
      "postiveExpenseTotal": this.postiveExpenseTotal,    
      "negativeExpenseTotal": this.negativeExpenseTotal,    
      "expenseImage": this.expenseImage, 
    };
  }

  Expense.fromSavedJson(Map<String, dynamic> data) {
    expenseId = data["expenseId"];
    expenseName = data["expenseName"];
    postiveExpenseTotal = data['postiveExpenseTotal'];
    negativeExpenseTotal = data['negativeExpenseTotal'];
    expenseImage = data['expenseImage'];
  }

  static Future<void> saveExpenseForDate(DateTime dateTime, List<Expense> expenseList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savingList = [];
    for(int i =0; i < expenseList.length; i ++)
    {
      Map<String, dynamic> json = expenseList[i].toJson();
      String newAddition = jsonEncode(Expense.fromSavedJson(json));
      savingList.add(newAddition);
    }
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    await prefs.setStringList(dateTimeKey, savingList);
  }

  static Future getSavedExpenseListForDate(DateTime dateTime) async {
    String dateTimeKey = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    List<Expense> savedListForDate = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('$dateTimeKey') ?? [];
    for(int i=0; i < alreadySaved.length; i++)
    {
      Map<String, dynamic> decodeList = jsonDecode(alreadySaved[i]);
      Expense exercise = Expense.fromSavedJson(decodeList);
      savedListForDate.add(exercise);
    }
    return savedListForDate;
  }
}