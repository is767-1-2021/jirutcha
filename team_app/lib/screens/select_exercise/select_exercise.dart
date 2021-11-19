import 'package:dropdown_search/dropdown_search.dart';
import 'package:exercise_app/model/exercise.dart';
import 'package:exercise_app/screens/add_custom_exercise/add_custom_exercise.dart';
import 'package:exercise_app/services/app_controller.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectExercise extends StatefulWidget {

  final List<Exercise> selectedDayExerciseList;
  final String selectedDateText;
  final DateTime selectedDate;
  SelectExercise({required this.selectedDateText, required this.selectedDate, required this.selectedDayExerciseList});

  @override
  _SelectExerciseState createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {

  List<Exercise> exercises = [];
  Exercise? selectedExercise;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllExercises(); //From Firebase
  }
  
  Future<void> getAllExercises() async {
    exercises = await AppController().getAllExercises();
    //Remove already selected exercises if any
    for(int i=0; i < widget.selectedDayExerciseList.length; i ++){
      exercises.removeWhere((exercise) => exercise.exerciseId == widget.selectedDayExerciseList[i].exerciseId);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> selectTime() async {
    DateTime showTime = DateTime.now();
    showTime = new DateTime(showTime.year, showTime.month, showTime.day, 1, 0, 0, 0, 0);

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(showTime),
      initialEntryMode: TimePickerEntryMode.dial
    );

    if(time == null)
      print('Time canceled');
    else
    {
      print(time.hour);
      int totalMinutes = (time.hour * 60) + time.minute;
      selectedExercise!.userTimeMinutesSelected = totalMinutes;
      selectedExercise!.userTimeSelected = (time.minute >0) ? "${time.hour}:${time.minute}" : "${time.hour}";
      selectedExercise!.userTimeBasedCalories = (selectedExercise!.userTimeMinutesSelected * selectedExercise!.caloriesPerMinute).toInt();
      widget.selectedDayExerciseList.add(selectedExercise!); 
      //remove selected exercise from list
      exercises.removeWhere((exercise) => exercise.exerciseId == selectedExercise!.exerciseId);
      setState(() {});
    }
  }

  Future<void> showCustomExerciseDialog() async {
    dynamic customCategoryAdded = await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: AddCustomExercise(),
      )
    );

    //Check if new customer category added
    if(customCategoryAdded != null)
    {
      setState(() {
        widget.selectedDayExerciseList.add(customCategoryAdded);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          '${widget.selectedDateText}',
          style: TextStyle(
            fontSize: SizeConfig.fontSize * 2
          ),
        ),    
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: showCustomExerciseDialog,
            child: Container(
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Custom Exercise',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: (loading) ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Exercises
            if(exercises.length>0)
            Container(
              height: SizeConfig.blockSizeVertical * 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: DropdownSearch<Exercise>(
                  mode: Mode.BOTTOM_SHEET,
                  hint: "Search for Exercies",
                  items: exercises,
                  itemAsString: (Exercise u){
                    return u.exerciseName + '\n' + u.totalTimeInHours.toString() + "hours" + " - " + u.exerciseKCalPerHour.toString();
                  },
                  onChanged: (data) {
                    setState(() {
                      selectedExercise = data;  
                      selectTime();
                    });
                  },
                  showSearchBox: true,
                  //searchBoxDecoration: null,
                  dropdownSearchDecoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical:0),
                    border: InputBorder.none,
                  ),
                  dropdownBuilder: _customDropDownExample,
                ),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView.builder(
                itemCount: widget.selectedDayExerciseList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return selectedExerciseCell(widget.selectedDayExerciseList[index], index);
                })
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await Exercise.saveExercisesForDate(widget.selectedDate, widget.selectedDayExerciseList);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: SizeConfig.blockSizeVertical * 7,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.fontSize * 2.3
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, Exercise? exercise, String itemDesignation) {
    return Container(
      child :Text(
        'Search for Exercise',
        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.fontSize * 2),
      ),
    );
  }

  Widget selectedExerciseCell(Exercise exercise, int index){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${exercise.exerciseName}',
              style: TextStyle(
                fontSize: SizeConfig.fontSize * 2.2,
                fontWeight: FontWeight.w500
              ),
            ),
            GestureDetector(
              onTap: () async {
                widget.selectedDayExerciseList.removeAt(index);
                setState(() {});
                await Exercise.saveExercisesForDate(widget.selectedDate, widget.selectedDayExerciseList); 
              },
              child: Icon(Icons.remove_circle, color: Colors.red,)
            )
          ],
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [                   
              Text(
                '${exercise.userTimeSelected} hour',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                ),
              ),


              Text(
                '${exercise.userTimeBasedCalories} kcal',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}