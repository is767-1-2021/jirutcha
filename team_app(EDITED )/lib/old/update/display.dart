import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายงานอาหาร")),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Ondiet_menu").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(document["kcal"]),
                      ),
                    ),
                    title: Text(document["foods"] + document["drink"]),
                    subtitle: Text(document["email"]),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
