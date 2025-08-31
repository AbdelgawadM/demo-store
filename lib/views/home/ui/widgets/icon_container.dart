import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, this.onPressed, required this.icon});
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: AppColors.kBordersideColor)
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black, size: 22),
      ),
    );
  }
}
