import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/cubits/details_cubit/details_cubit.dart';
import 'package:our_store/core/cubits/details_cubit/details_state.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:our_store/core/widgets/custom_cashed_image.dart';

class DiscountDetailsView extends StatefulWidget {
  const DiscountDetailsView({super.key, required this.discountsViewModel});
  final DiscountsViewModel discountsViewModel;

  @override
  State<DiscountDetailsView> createState() => _DiscountDetailsViewState();
}

class _DiscountDetailsViewState extends State<DiscountDetailsView> {
  late final DetailsCubit detailsCubit;
  // late final String userId = AuthCubit().client.auth.currentUser!.id;
  @override
  void initState() {
    super.initState();
    detailsCubit = context.read<DetailsCubit>()
      ..getDiscountDetails(
        productId: widget.discountsViewModel.productViewModel.productId,
        discountId: widget.discountsViewModel.discountId,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discountsViewModel.productViewModel.name),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return state is DiscountDetailsSuccess
              ? ListView(
                  children: [
                    CustomCashedImage(
                      imageUrl:
                          widget.discountsViewModel.productViewModel.imageUrl,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.discountsViewModel.productViewModel.name,
                              ),
                              Text(
                                widget.discountsViewModel.productViewModel.price
                                    .toString(),
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 16,
                                  color: AppColors.kGreyColor,
                                ),
                              ),
                              Text(
                                widget.discountsViewModel.newPrice.toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget
                                        .discountsViewModel
                                        .productViewModel
                                        .avgRate
                                        .toString(),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amberAccent,
                                  ),
                                ],
                              ),
                              const Icon(Icons.favorite),
                            ],
                          ),
                          Text(state.discountDetailsModel.first.description),
                          RatingBar.builder(
                            initialRating:
                                state.discountDetailsModel.first.rate,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {},
                          ),
                          const CustomTextField(
                            keyboardType: TextInputType.multiline,
                            hint: Text('comment here...'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const CustomIndicator();
        },
      ),
    );
  }
}
