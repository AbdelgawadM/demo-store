import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_state.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/home/ui/widgets/custom_padding.dart';
import 'package:our_store/views/home/ui/widgets/product.dart';
import 'package:our_store/views/product_details/ui/products_details_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.productViewModel,
    required this.title,
  });
  final List<ProductViewModel> productViewModel;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductDetailsSuccess) {
              final cubit = context.read<ProductDetailsCubit>();
              final productDetailsModel = state.productDetailsModel;

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
                : CustomPadding(
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productViewModel.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemBuilder: (context, index) => Product(
                            productViewModel: productViewModel[index],
                            onTap: () {
                              final ProductDetailsCubit cubit = context
                                  .read<ProductDetailsCubit>();
                              cubit.selectedIndex = index;
                              cubit.getProductDetails(
                                id: productViewModel[index].id,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
