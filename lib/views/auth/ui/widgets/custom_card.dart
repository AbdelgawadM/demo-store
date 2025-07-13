import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.margin, this.padding});
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? EdgeInsets.all(24),
      color: AppColors.kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Padding(padding: padding ?? EdgeInsets.all(16), child: child),
    );
  }
}
