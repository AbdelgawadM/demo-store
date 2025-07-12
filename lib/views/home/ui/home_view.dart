import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/models/category.dart';
import 'package:our_store/views/home/widgets/category_builder.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final List<Category> categories = [
    Category(icon: Icons.tv, label: 'Electronics'),
    Category(icon: Icons.sports, label: 'Sports'),
    Category(icon: Icons.collections, label: 'Collections'),
    Category(icon: Icons.tv, label: 'Electronics'),
    Category(icon: Icons.tv, label: 'Electronics'),
    Category(icon: Icons.tv, label: 'Electronics'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 20,
        children: [
          SizedBox(height: 0),
          CustomTextField(
            hint: Text('Search in Market...'),
            keyboardType: TextInputType.webSearch,
            fillColor: AppColors.kWhiteColor,
            sufIcon: ElevatedButton.icon(
              onPressed: () {},
              label: Icon(Icons.search, color: AppColors.kWhiteColor, size: 24),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
            ),
          ),
          // Image(image: AssetImage('assets/images/buy.jpg'))
          SizedBox(
            height: 100,
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryBuilder(category: categories[index]),
            ),
          ),
        ],
      ),
    );
  }
}
