import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.margin, required this.padding});
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: AppColors.kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
