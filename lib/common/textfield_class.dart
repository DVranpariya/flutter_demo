import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  const AddTextField({
    this.name,
    this.keyBoardType,
    this.controllerType,
  });

  final String name;
  final TextInputType keyBoardType;
  final TextEditingController controllerType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Valid text';
        }
        return null;
      },
      keyboardType: keyBoardType,
      controller: controllerType,
      decoration:
          InputDecoration(border: UnderlineInputBorder(), hintText: name),
    );
  }
}
