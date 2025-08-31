import 'package:flutter/material.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/ui/widgets/category.dart';
import 'package:our_store/views/products/ui/products_screen.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 5),
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Category(
        category: categories[index],
        onTap: () {
          navigateTo(
            context,
            ProductsScreen(categoryModel: categories[index]),
          );
        },
      ),
    );
  }
}
