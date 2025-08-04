import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/products/ui/products_screen.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigateTo(context, const ProductsScreen());
          },
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
            child: Icon(Icons.collections, size: 32),
          ),
        ),
        const SizedBox(height: 5),
        Text(category.label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
