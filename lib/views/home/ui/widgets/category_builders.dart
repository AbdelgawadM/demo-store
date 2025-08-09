import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/core/cubits/product_view_cubit/product_view_states.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';
import 'package:our_store/views/home/ui/widgets/category.dart';
import 'package:our_store/views/products/ui/products_screen.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductViewCubit(),
      child: BlocConsumer<ProductViewCubit, ProductViewState>(
        listener: (context, state) {
          if (state is ProductViewSuccess) {
            final productViewModel = state.producttViewModel;
            final cubit = context.read<ProductViewCubit>();
            final selected = cubit.selectedIndex;

            navigateTo(
              context,
              ProductsScreen(
                productViewModel: productViewModel,
                title: categories[selected!].label,
              ),
            );
          }
        },
        builder: (context, state) {
          return state is ProductViewLoading
              ? const CustomIndicator()
              : ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Category(
                    category: categories[index],
                    onTap: () {
                      ProductViewCubit cubit = context.read<ProductViewCubit>();
                      cubit.selectedIndex = index;
                      cubit.getProductView(category: categories[index].label);
                    },
                  ),
                );
        },
      ),
    );
  }
}
