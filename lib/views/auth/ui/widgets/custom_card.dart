
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(24),
      color: AppColors.kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}