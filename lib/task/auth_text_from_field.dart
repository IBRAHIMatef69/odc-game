import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  String hintText;
  final Function validator;
  final TextInputType textInputType;
    Widget? prefixIcon;
    Widget? suffixIcon;
    Color? inputColor;


  TextFromFieldWidget({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    required this.textInputType,
      this.prefixIcon,this.inputColor,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: EXTFORMFIELDCOLOR,
      style: TextStyle(color:inputColor?? PARAGRAPH.withOpacity(.6)),
      keyboardType: textInputType,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          prefixIcon: prefixIcon ,
          suffixIcon: suffixIcon,
          // label: Text(
          //   hintText,
          //   style: TextStyle(color: EXTFORMFIELDCOLOR),
          // ),
          hintText: hintText,
          hintStyle: TextStyle(
            color:inputColor?? DISABLED,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: EXTFORMFIELDCOLOR,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}const Color PARAGRAPH=Color(0xff3A3A3A);
const Color EXTFORMFIELDCOLOR=Color(0xffF6F6F6);const Color DISABLED=Color(0xffB7B7B7);
