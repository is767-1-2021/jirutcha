import 'package:exercise_app/model/drink.dart';
import 'package:exercise_app/screens/select_drink/select_drink.dart';

import 'package:exercise_app/utils/size_config.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DrinkPage extends StatefulWidget {

  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  
  List monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  bool showCalender = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String currentCalenderMonth = "";
  String selectedHeading = "";
  DateTime selectedDate = DateTime.now();
  DateTime userSelectedDate = DateTime.now();
  List<Drink> selectedDateDrinks = [];
  String totalCalories = "-";
  String totalCups = "0";

  @override
  void initState() {
    super.initState();
    currentCalenderMonth = monthNames[DateTime.now().month-1];
    selectedHeading = 'Today';
    loadSavedDrinkForSelectedDay();
  }

  Future<void> loadSavedDrinkForSelectedDay() async {
    selectedDateDrinks = await Drink.getSavedDrinksForDate(userSelectedDate);
    setState(() {
      calculateTotalCaloriesBurnedAndHours();
    });
  }

  void calculateTotalCaloriesBurnedAndHours() {
    double totalCupsOfDrink = 0;
    int calories = 0;
    for(int i=0; i < selectedDateDrinks.length; i++)
    {
      totalCupsOfDrink = (selectedDateDrinks[i].userCupSelected) + totalCupsOfDrink;
      calories = selectedDateDrinks[i].userBasedCalories + calories;
    }
    totalCalories = calories.toString();
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    totalCups = totalCupsOfDrink.toString().replaceAll(regex, "");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        brightness: Brightness.dark,
        title: InkWell(
          onTap: (){
            setState(() {
              showCalender = !showCalender;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (showCalender) ? '$currentCalenderMonth' : '$selectedHeading',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 2
                ),
              ),
              SizedBox(width: 10,),
              Icon((showCalender) ? Icons.arrow_drop_down : Icons.arrow_drop_up_outlined)
            ],
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              if(showCalender)
              Container(
                color: Colors.green,
                child: TableCalendar(
                  headerVisible: false,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle (color: Colors.white, fontSize: SizeConfig.fontSize * 2.5, fontWeight: FontWeight.bold)
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle:  TextStyle(color: Colors.white),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle
                    ),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    selectedTextStyle:  TextStyle(color: Colors.green),
                    selectedDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    ),
                    weekendTextStyle: TextStyle(color: Colors.white),
                  ),
                  firstDay: DateTime(2021),
                  lastDay: DateTime(2100),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        if(_selectedDay!.day == DateTime.now().day && _selectedDay!.month == DateTime.now().month && _selectedDay!.year == DateTime.now().year)
                          selectedHeading = "Today";
                        else
                          selectedHeading = DateFormat('EEEE, MMM dd').format(_selectedDay!);
                        userSelectedDate = _selectedDay!;
                        showCalender = false;
                        loadSavedDrinkForSelectedDay();
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      if(_focusedDay.year == DateTime.now().year)
                        currentCalenderMonth = monthNames[focusedDay.month-1];
                      else
                        currentCalenderMonth = monthNames[focusedDay.month-1] + " " + focusedDay.year.toString();
                    });
                  },
                ),
              ),
      
              //Exercise View
              drinkView(),         
            ],
          ),
        ),
      ),
    );
  }

  Widget drinkView(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'DRINKS DIARY',
              style: TextStyle(
                fontSize: SizeConfig.fontSize * 1.8,
                color: Colors.black54
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calories',
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    '$totalCalories',
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize * 1.9,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: ListTile(
                      onTap: () async {
                        await Get.to(SelectDrink(selectedDateText: selectedHeading, selectedDate: userSelectedDate,selectedDayDrinkList : selectedDateDrinks));
                        setState(() {
                          calculateTotalCaloriesBurnedAndHours();
                        });
                      },
                      leading: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.add, color: Colors.white,),
                      ),
                      title: Text(
                        'Drink',
                        style: TextStyle(
                          fontSize: SizeConfig.fontSize * 2.2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Text(
                       '$totalCalories',
                        style: TextStyle(
                          fontSize: SizeConfig.fontSize * 2.2,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(     
                    child: ExpansionTileCard(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                      ),
                      finalPadding: EdgeInsets.all(0),
                      title: Text(
                       '$totalCups cup',
                        style: TextStyle(
                          fontSize: SizeConfig.fontSize * 1.7,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: (selectedDateDrinks.isEmpty) ? Container(width: 0,) : Icon(Icons.arrow_drop_down_sharp),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 0),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedDateDrinks.length,
                              itemBuilder: (context, index){          
                                return drinkCell(selectedDateDrinks[index]);
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget drinkCell(Drink drink){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(
          '${drink.drinkName}',
          style: TextStyle(
            fontSize: SizeConfig.fontSize * 2.2,
            fontWeight: FontWeight.w500
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            '${drink.userCupSelected} cup',
            style: TextStyle(
              fontSize: SizeConfig.fontSize * 1.8,
              fontWeight: FontWeight.w500,
              color: Colors.green
            ),
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 10),
          child: Text(
            '${drink.userBasedCalories}',
            style: TextStyle(
              fontSize: SizeConfig.fontSize * 1.8,
              fontWeight: FontWeight.w500,
              color: Colors.green
            ),
          ),
        ),
      )
    );
  }
}