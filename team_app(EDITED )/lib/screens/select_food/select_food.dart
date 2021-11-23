import 'package:dropdown_search/dropdown_search.dart';
import 'package:exercise_app/model/food.dart';
import 'package:exercise_app/screens/add_custom_food/add_custom_food.dart';
import 'package:exercise_app/services/food_controller.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectFood extends StatefulWidget {

  final List<Food> selectedDayFoodList;
  final String selectedDateText;
  final DateTime selectedDate;
  SelectFood({required this.selectedDateText, required this.selectedDate, required this.selectedDayFoodList});

  @override
  _SelectFoodState createState() => _SelectFoodState();
}

class _SelectFoodState extends State<SelectFood> {

  List<Food> foods = [];
  Food? selectedFood;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllFoods(); //From Firebase
  }
  
  Future<void> getAllFoods() async {
    foods = await FoodController().getAllFoods();
    //Remove already selected exercises if any
    for(int i=0; i < widget.selectedDayFoodList.length; i ++){
      foods.removeWhere((food) => food.foodId == widget.selectedDayFoodList[i].foodId);
    }
    setState(() {
      loading = false;
    });
  }


  Future<void> showCustomFoodDialog() async {
    dynamic customCategoryAdded = await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: AddCustomFood(),
      )
    );

    //Check if new customer category added
    if(customCategoryAdded != null)
    {
      setState(() {
        widget.selectedDayFoodList.add(customCategoryAdded);
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
            onTap: showCustomFoodDialog,
            child: Container(
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Custom Food',
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
            if(foods.length>0)
            Container(
              height: SizeConfig.blockSizeVertical * 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: DropdownSearch<Food>(
                  mode: Mode.BOTTOM_SHEET,
                  hint: "Search for Foods",
                  items: foods,
                  itemAsString: (Food u){
                    return u.foodName + '\n' + u.totalDishes.toString() + "Dishes" + " - " + u.foodKCalPerDish.toString();
                  },
                  onChanged: (data) {
                    setState(() {
                      selectedFood = data;  
                  
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
                itemCount: widget.selectedDayFoodList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return selectedFoodCell(widget.selectedDayFoodList[index], index);
                })
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await Food.saveFoodsForDate(widget.selectedDate, widget.selectedDayFoodList);
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

  Widget _customDropDownExample(BuildContext context, Food? food, String itemDesignation) {
    return Container(
      child :Text(
        'Search for Foods',
        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.fontSize * 2),
      ),
    );
  }

  Widget selectedFoodCell(Food food, int index){
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
              '${food.foodName}',
              style: TextStyle(
                fontSize: SizeConfig.fontSize * 2.2,
                fontWeight: FontWeight.w500
              ),
            ),
            GestureDetector(
              onTap: () async {
                widget.selectedDayFoodList.removeAt(index);
                setState(() {});
                await Food.saveFoodsForDate(widget.selectedDate, widget.selectedDayFoodList); 
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
                '${food.userDishselected} dish',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                ),
              ),


              Text(
                '${food.userBasedCalories} kcal',
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