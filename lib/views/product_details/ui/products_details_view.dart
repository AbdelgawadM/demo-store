import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_store/core/models/product_details_model.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class ProductsDetailsView extends StatelessWidget {
  const ProductsDetailsView({
    super.key,
    required this.productViewModel,
    required this.productDetailsModel,
  });
  final ProductViewModel productViewModel;
  final ProductDetailsModel productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productViewModel.name),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          CustomCashedImage(imageUrl: productViewModel.imageUrl),
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
                    Text(productViewModel.name),
                    Text(productViewModel.price.toString()),
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
                Text(productDetailsModel.description),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
      ),
    );
  }
}
