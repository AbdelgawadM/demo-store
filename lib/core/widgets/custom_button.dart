import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.backColor = AppColors.kPrimaryColor,
    this.frontColor = AppColors.kWhiteColor,
  });
  final void Function()? onPressed;
  final String label;
  final Color frontColor;
  final Color backColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backColor),
        foregroundColor: WidgetStatePropertyAll(frontColor),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
