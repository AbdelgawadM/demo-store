import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/custom_list.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
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
      child: ListView(
        children: [
          SizedBox(height: 20),
          SearchTxtField(),
          SizedBox(height: 20),
          Image(image: AssetImage('assets/images/buy.jpg')),
          SizedBox(height: 20),
          Text('Popular Categories', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CategoryBuilder(category: categories[index]),
            ),
          ),
          SizedBox(height: 20),
          Text('Recently Products', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          CustomList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
