// import 'package:flutter/material.dart';
// import 'package:flutter_first_app/common/textfield_class.dart';
// import 'package:flutter_first_app/provider/provider_second_screen.dart';
// import 'package:flutter_first_app/View/data_model.dart';
// import 'package:provider/provider.dart';
//
// import 'provider_model.dart';
//
// class ProviderHomeScreen extends StatefulWidget {
//   @override
//   _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
// }
//
// class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
//   List<UserData> userData = [];
//   String dobSet;
//   String ratingSet;
//   TextEditingController nameCon = TextEditingController();
//   TextEditingController phoneCon = TextEditingController();
//   TextEditingController emailCon = TextEditingController();
//
//   void clearText() {
//     nameCon.clear();
//     phoneCon.clear();
//     emailCon.clear();
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.add,
//           size: 35,
//         ),
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('User Details'),
//                 content: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       AddTextField(
//                         name: 'enter your name',
//                         controllerType: nameCon,
//                       ),
//                       AddTextField(
//                         name: 'enter your phone',
//                         keyBoardType: TextInputType.number,
//                         controllerType: phoneCon,
//                       ),
//                       AddTextField(
//                         name: 'enter your email',
//                         keyBoardType: TextInputType.emailAddress,
//                         controllerType: emailCon,
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, 'Cancel');
//                       },
//                       child: Text('Cancel')),
//                   TextButton(
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           setState(() {
//                             /// TODO for value add in list
//                             userData.add(UserData(nameCon.text, emailCon.text,
//                                 dobSet, ratingSet));
//                           });
//                           Navigator.pop(context, 'Add');
//                         }
//                       },
//                       child: Text('Add')),
//                 ],
//               );
//             },
//           );
//
//           clearText();
//         },
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: userData.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.all(20),
//               child: GestureDetector(
//                 onTap: () async {
//                   context.read<ProviderModel>().name = userData[index].name;
//                   context.read<ProviderModel>().email = userData[index].date;
//                   await Navigator.push(context,
//                       MaterialPageRoute(builder: (BuildContext context) {
//                     return SecondScreenProvider();
//                   }));
//
//                   /// TODO for data return
//                   setState(() {
//                     userData[index].name = context.read<ProviderModel>().name;
//                     userData[index].date = context.read<ProviderModel>().email;
//                   });
//                   //print(value);
//                 },
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           //color: Colors.red,
//                           width: MediaQuery.of(context).size.width / 1.3,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   userData[index].name,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 22),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   userData[index].date,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 18),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     userData.removeAt(index);
//                                   });
//                                 },
//                                 child: Icon(Icons.delete)),
//                             GestureDetector(
//                                 onTap: () {
//                                   ///TODO same value show in textField
//
//                                   setState(() {
//                                     nameCon.text = userData[index].name;
//                                     emailCon.text = userData[index].date;
//                                   });
//
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: Text('User Details'),
//                                         content: Form(
//                                           key: _formKey,
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               AddTextField(
//                                                 name: 'enter your name',
//                                                 controllerType: nameCon,
//                                               ),
//                                               AddTextField(
//                                                 name: 'enter your phone',
//                                                 keyBoardType:
//                                                     TextInputType.number,
//                                                 controllerType: phoneCon,
//                                               ),
//                                               AddTextField(
//                                                 name: 'enter your email',
//                                                 keyBoardType:
//                                                     TextInputType.emailAddress,
//                                                 controllerType: emailCon,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(
//                                                     context, 'Cancel');
//                                               },
//                                               child: Text('Cancel')),
//                                           TextButton(
//                                               onPressed: () {
//                                                 if (_formKey.currentState
//                                                     .validate()) {
//                                                   ///TODO value update
//                                                   setState(() {
//                                                     userData[index].name =
//                                                         nameCon.text;
//
//                                                     userData[index].date =
//                                                         emailCon.text;
//                                                   });
//                                                   Navigator.pop(
//                                                       context, 'Update');
//                                                 }
//                                               },
//                                               child: Text('Update')),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: Icon(Icons.edit)),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(color: Colors.grey, blurRadius: 10)
//                       ],
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
