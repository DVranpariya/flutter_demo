import 'package:flutter/material.dart';
import 'package:flutter_first_app/View/home_screen_with_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'controller/add_product_controller.dart';
import 'model/provider_model.dart';

void main() async {
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreenWithModel(),
    );
  }

  AddProductList _addProductList = Get.put(AddProductList());
}
