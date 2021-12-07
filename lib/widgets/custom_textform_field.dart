// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? initVal;
  final String? hintText;
  final bool readOnly;
  final bool backColor;
  final bool isMob;
  CustomTextFormField(
      {this.initVal,
      this.hintText,
      this.isMob = false,
      this.readOnly = false,
      this.backColor = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: initVal,
      controller: initVal,
      readOnly: readOnly,
      maxLength: isMob ? 10 : 50,
      keyboardType: isMob ? TextInputType.phone : TextInputType.name,
      textInputAction: TextInputAction.go,
      decoration: InputDecoration(
          hintText: hintText,
          counterText: "",
          fillColor: !backColor ? Colors.white : Colors.grey.shade300,
          filled: true,
          hintStyle: TextStyle(fontSize: 12.0),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          )),
    );
  }
}
