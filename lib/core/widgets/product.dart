import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/favorite/logic/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/core/widgets/custom_cashed_image.dart';

class Product extends StatefulWidget {
  const Product({super.key, this.onTap, required this.productViewModel});
  final void Function()? onTap;

  final ProductViewModel productViewModel;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final SupabaseService service = SupabaseService();
  late FavoriteCubit favoriteCubit = context.read<FavoriteCubit>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomCard(
        padding: const EdgeInsets.all(0),
        child: Column(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: const BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                // topRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  CustomCashedImage(imageUrl: widget.productViewModel.imageUrl),
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
                        widget.productViewModel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          favoriteCubit.toggleFavorites(
                            productViewModel: widget.productViewModel,
                            productId: widget.productViewModel.productId,
                            userId: context
                                .read<AuthCubit>()
                                .client
                                .auth
                                .currentUser!
                                .id,
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: favoriteCubit.isFavColor
                              ? AppColors.kPrimaryColor
                              : AppColors.kGreyColor,
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
                            widget.productViewModel.price.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   widget.productViewModel.oldPrice.toString(),
                          //   style: const TextStyle(
                          //     decoration: TextDecoration.lineThrough,
                          //     fontSize: 16,
                          //     color: AppColors.kGreyColor,
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.productViewModel.avgRate.toString()),
                          const Icon(Icons.star, color: Colors.amberAccent),
                        ],
                      ),
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
