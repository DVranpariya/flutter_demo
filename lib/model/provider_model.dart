import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier{

  String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String _email;




  String get email => _email;

  set email(String value) {
    _email = value;
  }
}