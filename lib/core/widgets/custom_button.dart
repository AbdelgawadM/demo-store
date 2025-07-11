
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, this.onPressed, required this.label,
  });
final void Function()? onPressed ;
final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.kPrimaryColor,
        ),
        foregroundColor: WidgetStatePropertyAll(
          AppColors.kWhiteColor,
        ),
      ),
      child: Text(label),
    );
  }
}
