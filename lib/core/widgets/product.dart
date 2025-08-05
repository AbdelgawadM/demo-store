import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/core/models/product_model.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class Product extends StatefulWidget {
  const Product({
    super.key,
    this.onTap,
    required this.mainDiscounts,
    required this.index, 
  });
  final void Function()? onTap;

  final ProductModel mainDiscounts;

  final int index;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final SupabaseService service = SupabaseService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomCard(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: const BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  CustomCashedImage(imageUrl: widget.mainDiscounts.imageUrl!),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      width: 65,
                      height: 35,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: Text(
                        '${widget.mainDiscounts.discount}%',
                        style: const TextStyle(color: Colors.white70),
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
                        widget.mainDiscounts.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
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
                            widget.mainDiscounts.price.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.mainDiscounts.oldPrice.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                              color: AppColors.kGreyColor,
                            ),
                          ),
                        ],
                      ),
                      const CustomButton(label: 'Buy Now'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
