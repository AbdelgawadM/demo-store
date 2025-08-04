import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/product.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

class ProductBuilder extends StatelessWidget {
  const ProductBuilder({super.key, required this.discounts});

  final List<DiscountModel> discounts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Product(
        name: discounts[index].product.name,
        desc: discounts[index].product.description,
        price: discounts[index].product.price,
        oldPrice: discounts[index].product.oldPrice,
        discount: discounts[index].product.discount,
        imageUrl: discounts[index].product.imageUrl,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: discounts.length,
    );
  }
}
