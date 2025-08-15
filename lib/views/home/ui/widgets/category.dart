import 'package:flutter/material.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category, this.onTap});

  final CategoryModel category;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // hoverColor: AppColors.kPrimaryColor,
      // borderRadius: BorderRadius.circular(50), // ripple effect
      child: // space inside container
      Column(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.9),
                  blurRadius: 10,
                  // offset: const Offset(0, -1),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                category.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            category.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
