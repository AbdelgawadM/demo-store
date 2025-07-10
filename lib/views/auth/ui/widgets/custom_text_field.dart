
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.sufIcon,
    required this.keyboardType,
    this.isHidden = false,
  });
  final String label;
  final Widget? sufIcon;
  final TextInputType? keyboardType;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
        return null;
      },
      keyboardType: keyboardType,
      obscureText: isHidden,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.kBlackColor),
        labelText: label,
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
