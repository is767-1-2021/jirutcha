import 'package:exercise_app/model/exercise.dart';
import 'package:exercise_app/services/app_controller.dart';
import 'package:exercise_app/utils/constants.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomExercise extends StatefulWidget {

  @override
  _AddCustomExerciseState createState() => _AddCustomExerciseState();
}

class _AddCustomExerciseState extends State<AddCustomExercise> {

  TextEditingController exerciseName = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController timeField = TextEditingController();
  TimeOfDay? timeUser;

  Future<void> selectTime() async {
    DateTime showTime = DateTime.now();
    showTime = new DateTime(showTime.year, showTime.month, showTime.day, 1, 0, 0, 0, 0);

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(showTime),
      initialEntryMode: TimePickerEntryMode.dial
    );

    if(time != null)
    {
      timeUser = time;
      timeField.text = (time.minute >0) ? "${time.hour}:${time.minute}" : "${time.hour}";
      setState(() {});
    }
  }
  

  void saveExercise(){
    int totalMinutes = (timeUser!.hour * 60) + timeUser!.minute;
    Exercise customExercise = Exercise.fromEmpty();
    customExercise.exerciseId = DateTime.now().millisecondsSinceEpoch.toString();
    customExercise.exerciseName = exerciseName.text;
    customExercise.totalTimeInMinutes = totalMinutes;
    customExercise.exerciseKCalPerHour = int.parse(kcal.text);
    customExercise.totalTimeInHours = (customExercise.totalTimeInMinutes~/60).toInt();
    customExercise.caloriesPerMinute = customExercise.exerciseKCalPerHour/customExercise.totalTimeInMinutes;
    customExercise.userTimeMinutesSelected = totalMinutes;
    customExercise.userTimeSelected = (timeUser!.minute >0) ? "${timeUser!.hour}:${timeUser!.minute}" : "${timeUser!.hour}";
    customExercise.userTimeBasedCalories = (customExercise.userTimeMinutesSelected * customExercise.caloriesPerMinute).toInt();
    AppController().addExercise(customExercise.exerciseId, customExercise.exerciseName, customExercise.caloriesPerMinute);
    Get.back(result: customExercise);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            
            Container(
              child: Center(
                child: Text(
                  'Add Custom Exercise',
                  style :TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 2.3, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: exerciseName,
                  decoration: new InputDecoration(
                    hintText: "Exercise Name",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                  controller: kcal,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType : TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Calories Burned",
                    hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color : Colors.grey[300]
              ),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    selectTime();
                  },
                  child: TextField(
                    style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),
                    readOnly: true,
                    enabled: false,
                    controller: timeField,
                    decoration: new InputDecoration(
                      hintText: "Exercise Time",
                      hintStyle: TextStyle(color: Colors.green, fontSize: SizeConfig.fontSize * 1.8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),

          

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
                      )
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color : Colors.green
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(exerciseName.text.isEmpty)
                          Constants.showDialog('Please enter exercise name');
                        else if(kcal.text.isEmpty)
                          Constants.showDialog('Please enter calories burned');
                        else if(timeField.text.isEmpty)
                          Constants.showDialog('Please enter time');
                        else
                        {
                          saveExercise();
                        }
                      },
                      child: Text(
                        'Save',
                        style :TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize * 1.9),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}