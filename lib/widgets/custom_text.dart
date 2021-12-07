import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? textStyle;
  final String? text;
  const CustomText({this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.start,
      style: textStyle != null
          ? textStyle
          : TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800),
    );
  }
}
