import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_store/core/models/product_model.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/home/ui/widgets/custom_cashed_image.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.mainDiscounts,
    required this.restDiscounts,
  });
  final ProductModel mainDiscounts;
  final ProductModel restDiscounts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainDiscounts.name!),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ),
      body: ListView(
        children: [
          CustomCashedImage(imageUrl: mainDiscounts.imageUrl!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mainDiscounts.name!),
                    Text(mainDiscounts.price!.toString()),
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
                Text(restDiscounts.description!),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
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
