// import 'package:flutter/material.dart';
// //import 'package:team_app/pages/score.dart';
// //import 'package:team_app/pages/workout_result.dart';

// class Sitemap extends StatefulWidget {
//   @override
//   _MyHomePageState createState()
//   {
//     return _MyHomePageState();
//   }
// }
 
// class _MyHomePageState extends State<Sitemap> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("On Diet"),
//         centerTitle: true,
//       ),
//         // drawer: Sitemap(),
//         body:Card(
//           child:Container(
//             height: 100,
//             color: Colors.red,
//             child: Row(
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Expanded(
//                       child:Image.asset("assets/images/normal.png"),
//                       flex:2 ,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child:Container(
//                     alignment: Alignment.topLeft,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: ListTile(
//                             title: Text("Shape Of You"),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 5,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               SizedBox(width: 8,),
//                               TextButton(
//                                 child: Text("ADD TO QUEUE"),
//                                 onPressed: (){},
//                               ),
//                               SizedBox(width: 8,)
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   flex:8 ,
//                 ),
//               ],
//             ),
//           ),
//           elevation: 8,
//           margin: EdgeInsets.all(10),
//           ),
//         );
//        }
//       }