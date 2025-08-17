import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class Discountproduct extends StatefulWidget {
  const Discountproduct({
    super.key,
    required this.onTap,
    required this.discountsViewModel,
  });
  final void Function() onTap;

  final DiscountsViewModel discountsViewModel;

  @override
  State<Discountproduct> createState() => _DiscountproductState();
}

class _DiscountproductState extends State<Discountproduct> {
  final SupabaseService service = SupabaseService();

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
                topRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  CustomCashedImage(
                    imageUrl:
                        widget.discountsViewModel.productViewModel.imageUrl,
                  ),
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
                        '${widget.discountsViewModel.discount}%',
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
                        widget.discountsViewModel.productViewModel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<FavoriteCubit>().addToFavorites(
                            productViewModel:
                                widget.discountsViewModel.productViewModel,
                            productId: widget
                                .discountsViewModel
                                .productViewModel
                                .productId,
                            userId: context
                                .read<AuthCubit>()
                                .client
                                .auth
                                .currentUser!
                                .id,
                          );
                        },
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
                            widget.discountsViewModel.productViewModel.price
                                .toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   widget.discountsViewModel.oldPrice.toString(),
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
                          Text(
                            widget.discountsViewModel.productViewModel.avgRate
                                .toString(),
                          ),
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
