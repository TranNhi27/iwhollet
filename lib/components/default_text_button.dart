import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    Key? key,
    required this.text,
    required this.press,
    this.buttonColor = kPrimaryColor,
    this.textColor = kWhiteColor,
    this.width = 200.0
  }) : super(key: key);
  final String text;
  final Color textColor, buttonColor;
  final double width;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(width),
      height: getProportionateScreenHeight(46),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: buttonColor
      ),
      child: TextButton(
        onPressed: press,
        child: Text(text, style: TextStyle(color: textColor),),
      ),
    );
  }
}
