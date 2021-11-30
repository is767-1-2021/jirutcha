import 'package:dropdown_search/dropdown_search.dart';
import 'package:final_app/model/expense.dart';
import 'package:final_app/screens/add_custom_expense/add_custom_expense.dart';
import 'package:final_app/services/app_controller.dart';
import 'package:final_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectExpense extends StatefulWidget {

  final List<Expense> selectedDayExpensesList;
  final String selectedDateText;
  final DateTime selectedDate;
  SelectExpense({required this.selectedDateText, required this.selectedDate, required this.selectedDayExpensesList});

  @override
  _SelectExerciseState createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExpense> {

  List<String> expensesNames = [];
  List<dynamic> expenseImages = [];
  String selectedExpenseName = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllExpenseImages(); //From Firebase
  }
  
  Future<void> getAllExpenseImages() async {
    expensesNames = await AppController().getAllExpensesNames();
    expenseImages = await AppController().getAllExpenseImages();
    for(int i=0; i < widget.selectedDayExpensesList.length; i ++){
      expensesNames.removeWhere((expenseName) => expenseName == widget.selectedDayExpensesList[i].expenseName);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> setAmountForSelectExpense() async {
    dynamic customCategoryAdded = await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: AddCustomExpense(expenseImages: expenseImages, selectedExpenseName: (selectedExpenseName.isEmpty) ? '' : selectedExpenseName),
      )
    );

    //Check if new customer category added
    if(customCategoryAdded != null)
    {
      expensesNames.removeWhere((expenseName) => expenseName == selectedExpenseName); 
      setState(() {
        widget.selectedDayExpensesList.add(customCategoryAdded);
      });
    }
  }

  Future<void> showCustomExerciseDialog() async {
    dynamic customExpenseAdded = await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: AddCustomExpense(expenseImages: expenseImages, selectedExpenseName: '',),
      )
    );

    //Check if new customer category added
    if(customExpenseAdded != null)
    {
      //Add in firebase
      AppController().addExpenseNameInFirebase(customExpenseAdded.expenseName);
      setState(() {
        widget.selectedDayExpensesList.add(customExpenseAdded);
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
                  '+',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold, fontSize: 30
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

            if(expensesNames.length>0)
            Container(
              height: SizeConfig.blockSizeVertical * 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  hint: "Search for Expense",
                  items: expensesNames,
                  itemAsString: (String name){
                    return name.toString();
                  },
                  onChanged: (data) {
                    setState(() {
                      selectedExpenseName = data!;  
                      setAmountForSelectExpense();
                    });
                  },
                  showSearchBox: true,
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
                itemCount: widget.selectedDayExpensesList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return selectedExpenseCell(widget.selectedDayExpensesList[index], index);
                })
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await Expense.saveExpenseForDate(widget.selectedDate, widget.selectedDayExpensesList);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: SizeConfig.blockSizeVertical * 7,
          decoration: BoxDecoration(
            color: Colors.blue,
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

  Widget _customDropDownExample(BuildContext context, String? expenseName, String itemDesignation) {
    return Container(
      child :Text(
        'Search for Expense',
        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.fontSize * 2),
      ),
    );
  }

  Widget selectedExpenseCell(Expense expense, int index){
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
              '${expense.expenseName}',
              style: TextStyle(
                fontSize: SizeConfig.fontSize * 2.2,
                fontWeight: FontWeight.w500
              ),
            ),
            GestureDetector(
              onTap: () async {
                expensesNames.add( widget.selectedDayExpensesList[index].expenseName);
                widget.selectedDayExpensesList.removeAt(index);
                setState(() {});
                await Expense.saveExpenseForDate(widget.selectedDate, widget.selectedDayExpensesList); 
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
                '฿ ${expense.postiveExpenseTotal - expense.negativeExpenseTotal}',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
              ),


              Text(
                '',
                style: TextStyle(
                  fontSize: SizeConfig.fontSize * 1.8,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}