import 'package:flutter/material.dart';

class FoodFormModel extends ChangeNotifier {
  String? _date;
  String? _time;
  String? _menu;
  int? _kCal;
  int _score = 1;
  String? _diet = 'None';
  String? _meal;
  int? _calories;
  int _counter = 0;

  get score => this._score;

  set score(value) {
    this._score = value;
    notifyListeners();
  }

  get date => this._date;

  set date(value) {
    this._date = value;
    notifyListeners();
  }

  get time => this._time;

  set time(value) {
    this._time = value;
    notifyListeners();
  }

  get menu => this._menu;

  set menu(value) {
    this._menu = value;
    notifyListeners();
  }

  get kCal => this._kCal;

  set kCal(value) {
    this._kCal = value;
    notifyListeners();
  }

  get diet => this._diet;
  set diet(value) {
    this._diet = value;
    notifyListeners();
  }

  get meal => this._meal;
  set meal(value) {
    this._meal = value;
    notifyListeners();
  }

  get calories => this._calories;
  set calories(value) {
    this._calories = value;
    notifyListeners();
  }

  get counter => this._counter;
  set counter(value) {
    this._counter = value;
    notifyListeners();
  }
}
