import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/home/models/category.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kWhiteColor,
          child: Icon(category.icon, size: 32),
        ),
        SizedBox(height: 5),
        Text(category.label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
