
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class Product extends StatelessWidget {
  const Product({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
    );
  }
}
