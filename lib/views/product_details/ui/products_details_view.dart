import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_store/core/cubits/details_cubit/details_cubit.dart';
import 'package:our_store/core/cubits/details_cubit/details_state.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/core/widgets/custom_cashed_image.dart';

class ProductsDetailsView extends StatefulWidget {
  const ProductsDetailsView({super.key, required this.productViewModel});
  final ProductViewModel productViewModel;

  @override
  State<ProductsDetailsView> createState() => _ProductsDetailsViewState();
}

class _ProductsDetailsViewState extends State<ProductsDetailsView> {
  late DetailsCubit detailsCubit;

  @override
  void initState() {
    super.initState();
    detailsCubit = context.read<DetailsCubit>()
      ..getProductDetails(productId: widget.productViewModel.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productViewModel.name),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return state is ProductDetailsSuccess
              ? ListView(
                  children: [
                    CustomCashedImage(
                      imageUrl: widget.productViewModel.imageUrl,
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
                              Text(widget.productViewModel.name),
                              Text(widget.productViewModel.price.toString()),
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
                          Text(state.productDetailsModel.first.description),
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
