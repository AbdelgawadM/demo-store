
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomArrowBtn extends StatelessWidget {
  const CustomArrowBtn({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: AppColors.kWhiteColor,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
