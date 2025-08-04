import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/cubits/cubit/products_cubit.dart';
import 'package:our_store/core/cubits/cubit/products_state.dart';
import 'package:our_store/views/home/logic/cubits/cubit/categories_cubit.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/product_builder.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/home/ui/widgets/category_builders.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CategoriesCubit categoryCubit;
  late ProductsCubit productCubit;

  @override
  void initState() {
    super.initState();
    categoryCubit = context.read<CategoriesCubit>()..getCategories();
    productCubit = context.read<ProductsCubit>()..getDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: RefreshIndicator(
        onRefresh: () async {
          await categoryCubit.getCategories(force: true);
          await productCubit.getDiscounts(force: true);
        },
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const SearchTxtField(),
            const SizedBox(height: 20),
            const Image(image: AssetImage('assets/images/buy.jpg')),
            const SizedBox(height: 20),
            const Text('Popular Categories', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const CustomIndicator();
                } else if (state is CategorySuccess) {
                  return SizedBox(
                    height: 100,
                    child: CategoryBuilder(categories: state.categoryModel),
                  );
                } else {
                  return const Center(child: Text('Error has Ocurred'));
                }
              },
            ),
            const SizedBox(height: 20),
            const Text('Products on sale', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is DiscountLoading) {
                  return const CustomIndicator();
                } else if (state is DiscountSuccess) {
                  return ProductBuilder(discounts: state.discountModel);
                } else {
                  return const Center(child: Text('Error has Ocurred'));
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
