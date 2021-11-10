import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/View/add_product_screen.dart';
import 'package:flutter_first_app/common/textfield_class.dart';
import 'package:flutter_first_app/controller/add_product_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/data_model.dart';

class HomeScreenWithModel extends StatefulWidget {
  @override
  _HomeScreenWithModelState createState() => _HomeScreenWithModelState();
}

class _HomeScreenWithModelState extends State<HomeScreenWithModel> {
  AddProductList _addProductList = Get.find();
  String dobSet;
  String ratingSet;

  TextEditingController nameCon = TextEditingController();
  TextEditingController launchCon = TextEditingController();

  void clearText() {
    nameCon.clear();
    launchCon.clear();
  }

  final _formKey = GlobalKey<FormState>();

  /// TODO Loading counter value on start
  Future<void> lodeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> spList = prefs.getStringList('userData');
      _addProductList.userData = spList
              ?.map((item) => UserData.fromMap(json.decode(item)))
              ?.toList() ??
          [];
    });
  }

  /// TODO Incrementing counter after click
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> spList = _addProductList.userData
              ?.map((item) => json.encode(item.toMap()))
              ?.toList() ??
          [];
      print('data============>>>>>>>>$spList');
      prefs.setStringList('userData', spList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFC806).withOpacity(.7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('DashBoard'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Get.to(AddProductScreen());

              clearText();
            },
          )
        ],
      ),
      body: SafeArea(
        child: GetBuilder<AddProductList>(
          builder: (controller) {
            return controller.userData.isEmpty
                ? Center(child: Text('Please Data Add'))
                : ListView.builder(
                    itemCount: controller.userData.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('date---${controller.userData[index].date}');
                      print('launch---${controller.userData[index].launch}');
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //color: Colors.red,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          controller.userData[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 22),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          controller.userData[index].date ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          controller.userData[index].launch ??
                                              '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          children: [
                                            Text('Popularity:  '),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  controller
                                                      .userData[index].rating),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Color(0xffFFC806),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Are you sure you want to delete?'),
                                                content: SingleChildScrollView(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Cancel');
                                                      },
                                                      child: Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          ///TODO value update
                                                          setState(() {
                                                            setState(() {
                                                              controller
                                                                  .userData
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          });
                                                          Navigator.pop(context,
                                                              'Update');
                                                        }
                                                      },
                                                      child: Text('delete')),
                                                ],
                                              );
                                            },
                                          );

                                          ///
                                        },
                                        child: Icon(Icons.delete)),
                                    GestureDetector(
                                        onTap: () {
                                          ///TODO same value show in textField

                                          setState(() {
                                            nameCon.text =
                                                controller.userData[index].name;
                                            launchCon.text = controller
                                                .userData[index].launch;
                                            ratingSet = controller
                                                .userData[index].rating;
                                            dobSet =
                                                controller.userData[index].date;
                                          });

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Edit Product'),
                                                content: SingleChildScrollView(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        AddTextField(
                                                          name:
                                                              'enter your name',
                                                          controllerType:
                                                              nameCon,
                                                        ),
                                                        DateTimePicker(
                                                          icon: Icon(
                                                            Icons.date_range,
                                                            color: Colors.grey,
                                                          ),
                                                          type:
                                                              DateTimePickerType
                                                                  .date,
                                                          dateMask:
                                                              'd MMM, yyyy',
                                                          initialValue:
                                                              'launchedAt',
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2100),
                                                          dateHintText:
                                                              'launchedAt',
                                                          selectableDayPredicate:
                                                              (date) {
                                                            // Disable weekend days to select from the calendar
                                                            if (date.weekday ==
                                                                    6 ||
                                                                date.weekday ==
                                                                    7) {
                                                              return false;
                                                            }

                                                            return true;
                                                          },
                                                          onChanged: (val) {
                                                            setState(() {
                                                              dobSet = val;
                                                            });
                                                            print(
                                                                '---------------dob  sey------$val');
                                                          },
                                                          validator: (val) {
                                                            print(val);
                                                            return null;
                                                          },
                                                          onSaved: (val) {
                                                            setState(() {
                                                              dobSet = val;
                                                            });
                                                          },
                                                        ),
                                                        AddTextField(
                                                          name: 'LaunchSite',
                                                          keyBoardType:
                                                              TextInputType
                                                                  .text,
                                                          controllerType:
                                                              launchCon,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  'Popularity:  '),
                                                              RatingBar.builder(
                                                                initialRating:
                                                                    1,
                                                                minRating: 1,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                itemSize: 20,
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFFC806),
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {
                                                                  ratingSet = rating
                                                                      .toString();
                                                                  print(rating);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Cancel');
                                                      },
                                                      child: Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          ///TODO value update
                                                          setState(() {
                                                            controller
                                                                    .userData[index]
                                                                    .name =
                                                                nameCon.text;
                                                            controller
                                                                    .userData[index]
                                                                    .rating =
                                                                ratingSet
                                                                    .toString();
                                                            controller
                                                                .userData[index]
                                                                .date = dobSet;
                                                            controller
                                                                    .userData[index]
                                                                    .launch =
                                                                launchCon.text;

                                                            saveData();
                                                          });
                                                          Navigator.pop(context,
                                                              'Update');
                                                        }
                                                      },
                                                      child: Text('Update')),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.edit)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,

                              // boxShadow: [
                              //   BoxShadow(color: Colors.grey, blurRadius: 10)
                              // ],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
