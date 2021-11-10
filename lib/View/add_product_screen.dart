import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/common/preferenceManager.dart';
import 'package:flutter_first_app/common/textfield_class.dart';
import 'package:flutter_first_app/controller/add_product_controller.dart';
import 'package:flutter_first_app/model/data_model.dart';
import 'package:flutter_first_app/View/home_screen_with_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AddProductList _addProductList = Get.find();

  final _formKey = GlobalKey<FormState>();
  // List<UserData> userData = [];
  String dobSet;
  String ratingSet;

  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

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

  void clearText() {
    nameCon.clear();
    phoneCon.clear();
    emailCon.clear();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  snack() {
    return _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('o')));
  }

  bool isPlatform = PreferenceManager.getPlatForm() == null;

  @override
  void initState() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
      } else {
        print('not');
      }
    } catch (e) {
      PreferenceManager.setPlatForm(value: true);
      print('---get plat--${PreferenceManager.getPlatForm()}');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 2,
                    width: Get.width,
                    child: Image.asset(
                      'assets/images/product_pictures.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            Container(
              width: PreferenceManager.getPlatForm() == null
                  ? Get.width
                  : Get.width / 2,
              height: Get.height / 1.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    AddTextField(
                      name: 'Name',
                      controllerType: nameCon,
                    ),
                    DateTimePicker(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: 'launchedAt',
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      dateHintText: 'launchedAt',
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      onChanged: (val) {
                        setState(() {
                          dobSet = val;
                        });
                        print('---------------dob  sey------$val');
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
                      keyBoardType: TextInputType.text,
                      controllerType: emailCon,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text('Popularity:  '),
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Color(0xffFFC806),
                            ),
                            onRatingUpdate: (rating) {
                              ratingSet = rating.toString();
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width / 1.5,
                        height: Get.height / 14,
                        decoration: BoxDecoration(
                            color: Color(0xffFFC806).withOpacity(.8),
                            borderRadius: BorderRadius.circular(30)),
                        child: MaterialButton(
                          child: Text(
                            'Add Product',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                ratingSet.isNotEmpty &&
                                dobSet.isNotEmpty) {
                              setState(() {
                                /// TODO for value add in list
                                _addProductList.userData.add(UserData(
                                    nameCon.text,
                                    dobSet.toString(),
                                    emailCon.text,
                                    ratingSet));
                              });
                              await saveData();

                              Get.to(HomeScreenWithModel());
                            } else {
                              return _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(content: new Text('o')));
                              // Scaffold.of(context).showSnackBar(
                              //     new SnackBar(content: new Text('mmmmm')));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
