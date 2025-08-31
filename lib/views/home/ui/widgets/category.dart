import 'package:flutter/material.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/ui/widgets/hover_nav_item.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category, this.onTap});

  final CategoryModel category;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: HoverNavItem(
        title: category.label,
        imageUrl: category.imageUrl,
      ), // space inside container
    );
  }
}
