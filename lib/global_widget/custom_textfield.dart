import 'package:class20/const/all_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.obscureText = false,
      this.icon = null,
      this.keyboardType = TextInputType.emailAddress,
      this.icon1 = null});
  final TextInputType keyboardType;
  final Widget? icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Widget? icon1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: icon1,
        prefixIcon: icon != null ? icon : null,
        hintText: hintText,
        hintStyle: const TextStyle(color: AllColors.textBlackColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: AllColors.primaryColors.withOpacity(.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AllColors.secendaryColors,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.redAccent.shade700,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.redAccent.shade700,
          ),
        ),
      ),
    );
  }
}
