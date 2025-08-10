import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/logic/cubits/discounts_details_cubit/discounts_details_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_details_cubit/discounts_details_state.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class DiscountDetailsView extends StatefulWidget {
  const DiscountDetailsView({super.key, required this.discountsViewModel});
  final DiscountsViewModel discountsViewModel;

  @override
  State<DiscountDetailsView> createState() => _DiscountDetailsViewState();
}

class _DiscountDetailsViewState extends State<DiscountDetailsView> {
  late DiscountsDetailsCubit discountDetailsCubit;
  @override
  void initState() {
    super.initState();
    discountDetailsCubit = context.read<DiscountsDetailsCubit>()
      ..getDiscountsDetails(id: widget.discountsViewModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discountsViewModel.name),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<DiscountsDetailsCubit, DiscountsDetailsState>(
        builder: (context, state) {
          return state is DiscountsDetailsSuccess
              ? ListView(
                  children: [
                    CustomCashedImage(
                      imageUrl: widget.discountsViewModel.imageUrl,
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
                              Text(widget.discountsViewModel.name),
                              Text(
                                widget.discountsViewModel.price.toString(),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('0 '),
                                  Icon(Icons.star, color: Colors.amberAccent),
                                ],
                              ),
                              Icon(Icons.favorite),
                            ],
                          ),
                          Text(state.discountDetailsModel.first.description),
                          RatingBar.builder(
                            initialRating: 3,
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
