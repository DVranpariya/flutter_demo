import 'package:flutter_first_app/model/data_model.dart';
import 'package:get/get.dart';

class AddProductList extends GetxController {
  List<Map> productList = [];

  addList({String name, String date, String launchSite, String rating}) {
    productList.add(
        {'name': name, 'date': date, 'launch': launchSite, 'rating': rating});
    update();
  }

  removeList({int index}) {
    productList.removeAt(index);
    update();
  }

  List<UserData> userData = [];
}
