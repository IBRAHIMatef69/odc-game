import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function() onPressed;
  final Widget text;
  final double width;
  final Color buttonColor;

  const MainButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * .06,
        width: width,
        decoration: BoxDecoration(

          color: buttonColor,

          borderRadius: BorderRadius.circular(17),
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
