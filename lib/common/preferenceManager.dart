import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static allClearPreferenceManager() {
    return getStorage.erase();
  }

  static Future setPlatForm({bool value}) async {
    await getStorage.write("Platform", value);
  }

  static getPlatForm() {
    return getStorage.read("Platform");
  }
}
