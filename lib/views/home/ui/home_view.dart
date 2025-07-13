import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/models/category.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';
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
          CustomTextField(
            hint: Text(
              'Search in Market...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
          CustomCard(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              spacing: 10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      CustomCashedImage(),
                      Positioned(
                        child: Container(
                          alignment: Alignment.center,
                          width: 65,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: AppColors.kPrimaryColor,
                          ),
                          child: Text(
                            '10% OFF',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: AppColors.kGreyColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '320 LE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '400 LE',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 16,
                                  color: AppColors.kGreyColor,
                                ),
                              ),
                            ],
                          ),
                          CustomButton(label: 'Buy Now'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
