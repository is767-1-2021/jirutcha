import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'display.dart';
import 'model.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Ondietmenu myStudent =
      Ondietmenu(email: '', foods: '', drink: '', kcal: '');
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _ondietCollection =
      FirebaseFirestore.instance.collection("Ondiet_menu");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("รายการอาหาร"),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayScreen()));
                  },
                  child: Icon(Icons.add),
                ),
                body: Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชื่อ",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนชื่ออาหาร"),
                            onSaved: (String? foods) {
                              myStudent.foods = foods!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "เครื่องดื่ม",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรายการเครื่องดื่ม"),
                            onSaved: (String? drink) {
                              myStudent.drink = drink!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "อีเมล",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              EmailValidator(
                                  errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                              RequiredValidator(
                                  errorText: "กรุณาป้อนอีเมลด้วยครับ ^^")
                            ]),
                            onSaved: (String? email) {
                              myStudent.email = email!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Kcal",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนจำนวนKcal"),
                            onSaved: (String? kcal) {
                              myStudent.kcal = kcal!;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Text(
                                  "บันทึกข้อมูล",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await _ondietCollection.add({
                                      "foods": myStudent.foods,
                                      "drink": myStudent.drink,
                                      "email": myStudent.email,
                                      "kcal": myStudent.kcal
                                    });
                                    formKey.currentState!.reset();
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
