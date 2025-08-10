import 'package:flutter/material.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/views/home/ui/widgets/product.dart';
import 'package:our_store/views/product_details/ui/products_details_view.dart';

class ProductBuilder extends StatelessWidget {
  const ProductBuilder({super.key, required this.productViewModel});
  final List<ProductViewModel> productViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productViewModel.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => Product(
        productViewModel: productViewModel[index],
        onTap: () {
          navigateTo(
            context,
            ProductsDetailsView(productViewModel: productViewModel[index]),
          );
        },
      ),
    );
  }
}
