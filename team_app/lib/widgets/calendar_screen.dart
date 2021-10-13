import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calender'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
            child: Calendar(
              startOnMonday: true,
              selectedColor: Colors.blue,
              todayColor: Colors.red,
              eventColor: Colors.green,
              eventDoneColor: Colors.amber,
              bottomBarColor: Colors.deepOrange,
              onRangeSelected: (range){
                print('Selected Day ${range.from}, ${range.to}');
              },

              isExpanded: true,
              dayOfWeekStyle: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              bottomBarTextStyle: TextStyle(
                color: Colors.white,
              ),
              hideBottomBar: false,
              isExpandable: true,
              hideArrows: false,
              weekDays: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
            ),
          ),
      ),
    );
  }
}