import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_state.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/models/product_details_model.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/home/ui/widgets/product.dart';

import 'package:our_store/views/product_details/ui/products_details_view.dart';

class ProductBuilder extends StatelessWidget {
  const ProductBuilder({super.key, required this.productViewModel});

  final List<ProductViewModel> productViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsSuccess) {
          final ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          final List<ProductDetailsModel> productDetailsModel =
              state.productDetailsModel;

          final selected = cubit.selectedIndex;

          navigateTo(
            context,
            ProductsDetailsView(
              productViewModel: productViewModel[selected!],
              productDetailsModel: productDetailsModel.first,
            ),
          );
        }
      },
      builder: (context, state) {
        return state is ProductDetailsLoading
            ? const CustomIndicator()
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Product(
                  productViewModel: productViewModel[index],
                  onTap: () {
                    final ProductDetailsCubit cubit = context
                        .read<ProductDetailsCubit>();
                    cubit.selectedIndex = index;
                    cubit.getProductDetails(id: productViewModel[index].id);
                  },
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: productViewModel.length,
              );
      },
    );
  }
}
