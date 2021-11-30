import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/model/expense.dart';
import 'package:final_app/utils/constants.dart';
import 'package:final_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomExpense extends StatefulWidget {
  
  final List expenseImages;
  final String selectedExpenseName;
  AddCustomExpense({required this.expenseImages, required this.selectedExpenseName});

  @override
  _AddCustomExpenseState createState() => _AddCustomExpenseState();
}

class _AddCustomExpenseState extends State<AddCustomExpense> {

  TextEditingController expenseName = TextEditingController();
  TextEditingController expensePositiveBudget = TextEditingController();
  TextEditingController expenseNegativeBudget = TextEditingController();
  Map? selectedIconName;

  @override
  void initState() {
    super.initState();
    expenseName = TextEditingController(text: widget.selectedExpenseName);
  }

  void saveExpense(){
    Expense customExercise = Expense.fromEmpty();
    customExercise.expenseId = DateTime.now().millisecondsSinceEpoch.toString();
    customExercise.expenseName = expenseName.text;
    customExercise.postiveExpenseTotal = double.parse(expensePositiveBudget.text);
    customExercise.negativeExpenseTotal = double.parse(expenseNegativeBudget.text);
    customExercise.expenseImage = selectedIconName!['imageUrl'];
    //AppController().addExpenses(expenseId, expenseName, expenseTotal, expenseImage)(customExercise.exerciseId, customExercise.exerciseName, customExercise.caloriesPerMinute);
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
                  'Add Custom Expense',
                  style :TextStyle(color: Colors.blue, fontSize: SizeConfig.fontSize * 2.3, fontWeight: FontWeight.bold),
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
                  controller: expenseName,
                  decoration: new InputDecoration(
                    hintText: "Expense Detail",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: SizeConfig.fontSize * 1.8),
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
                  controller: expensePositiveBudget,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                  decoration: new InputDecoration(
                    hintText: "Earning (if non type 0)",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: SizeConfig.fontSize * 1.8),
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
                  controller: expenseNegativeBudget,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                  decoration: new InputDecoration(
                    hintText: "Spending (if non type 0)",
                    hintStyle: TextStyle(color: Colors.blue, fontSize: SizeConfig.fontSize * 1.8),
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
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: Text('Select Icon', style: TextStyle(color: Colors.blue, fontSize: SizeConfig.fontSize * 1.8),),// Not necessary for Option 1
                  value: selectedIconName,
                  isExpanded: true,
                  icon: Icon(                // Add this
                    Icons.arrow_drop_down,  // Add this
                    color: Colors.black,   // Add this
                  ),
                  underline: Container(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedIconName = newValue as Map;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                  items: widget.expenseImages.map((imageData) {
                    return DropdownMenuItem(
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(imageData['imageUrl']),
                              )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(imageData['name'],style: TextStyle(fontSize: SizeConfig.fontSize * 1.8),)
                        ],
                      ),
                      value: imageData,
                    );
                  }).toList(),
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
                      color : Colors.blue
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
                      color : Colors.blue
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(expenseName.text.isEmpty)
                          Constants.showDialog('Please enter expense name');
                        else if(expensePositiveBudget.text.isEmpty)
                          Constants.showDialog('Please enter positive expense budget');
                        else if(expenseNegativeBudget.text.isEmpty)
                          Constants.showDialog('Please enter negative expense budget');
                        else if(selectedIconName == null)
                          Constants.showDialog('Please select expense icon');
                        else
                        {
                          saveExpense();
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