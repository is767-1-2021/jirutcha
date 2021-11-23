import 'package:dropdown_search/dropdown_search.dart';
import 'package:exercise_app/model/drink.dart';
import 'package:exercise_app/screens/add_custom_drink/add_custom_drink.dart';
import 'package:exercise_app/services/drink_controller.dart';
import 'package:exercise_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDrink extends StatefulWidget {

  final List<Drink> selectedDayDrinkList;
  final String selectedDateText;
  final DateTime selectedDate;
  SelectDrink({required this.selectedDateText, required this.selectedDate, required this.selectedDayDrinkList});

  @override
  _SelectDrinkState createState() => _SelectDrinkState();
}

class _SelectDrinkState extends State<SelectDrink> {

  List<Drink> drinks = [];
  Drink? selectedDrink;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllDrinks(); //From Firebase
  }
  
  Future<void> getAllDrinks() async {
    drinks = await DrinkController().getAllDrinks();
    //Remove already selected exercises if any
    for(int i=0; i < widget.selectedDayDrinkList.length; i ++){
      drinks.removeWhere((drink) => drink.drinkId == widget.selectedDayDrinkList[i].drinkId);
    }
    setState(() {
      loading = false;
    });
  }


  Future<void> showCustomDrinkDialog() async {
    dynamic customCategoryAdded = await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: AddCustomDrink(),
      )
    );

    //Check if new customer category added
    if(customCategoryAdded != null)
    {
      setState(() {
        widget.selectedDayDrinkList.add(customCategoryAdded);
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
            onTap: showCustomDrinkDialog,
            child: Container(
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Custom Drink',
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
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("loading ${drinks.length}")
            ],
          ),

        ),
      ) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Exercises
            if(drinks.length > 0)
            Container(
              height: SizeConfig.blockSizeVertical * 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: DropdownSearch<Drink>(
                  mode: Mode.BOTTOM_SHEET,
                  hint: "Search for Drinks",
                  items: drinks,
                  itemAsString: (Drink u){
                    return u.drinkName + '\n' + u.totalCups.toString() + "cups" + " - " + u.drinkKCalPerCup.toString();
                  },
                  onChanged: (data) {
                    setState(() {
                      selectedDrink = data;  
                  
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
                itemCount: widget.selectedDayDrinkList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return selectedDrinkCell(widget.selectedDayDrinkList[index], index);
                })
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await Drink.saveDrinksForDate(widget.selectedDate, widget.selectedDayDrinkList);
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

  Widget _customDropDownExample(BuildContext context, Drink? drink, String itemDesignation) {
    return Container(
      child :Text(
        'Search for Drinks',
        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.fontSize * 2),
      ),
    );
  }

  Widget selectedDrinkCell(Drink drink, int index){
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
              '${drink.drinkName}',
              style: TextStyle(
                fontSize: SizeConfig.fontSize * 2.2,
                fontWeight: FontWeight.w500
              ),
            ),
            GestureDetector(
              onTap: () async {
                widget.selectedDayDrinkList.removeAt(index);
                setState(() {});
                await Drink.saveDrinksForDate(widget.selectedDate, widget.selectedDayDrinkList); 
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
                '${drink.totalCups} cup',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                ),
              ),


              Text(
                '${drink. drinkKCalPerCup} kcal',
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