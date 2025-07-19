import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.sufIcon,
    required this.keyboardType,
    this.isHidden = false,
    this.hint, this.fillColor=Colors.transparent, this.controller,
  });
  final String? label;
  final Widget? hint;
  final Widget? sufIcon;
  final TextInputType? keyboardType;
  final bool isHidden;
  final Color? fillColor;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
        return null;
      },
      controller:controller ,
      keyboardType: keyboardType,
      obscureText: isHidden,
      decoration: InputDecoration(
        fillColor:fillColor ,
        filled: true,
        labelStyle: TextStyle(color: AppColors.kBlackColor),
        labelText: label,
        hint: hint,
        hintStyle: TextStyle(color: AppColors.kBlackColor),
        suffixIcon: sufIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
        ),
      ),
    );
  }
}
