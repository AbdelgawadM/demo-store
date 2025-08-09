import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_cubit.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/views/home/logic/cubits/category_cubit/categories_cubit.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/home/ui/widgets/custom_padding.dart';
import 'package:our_store/views/home/ui/widgets/discount_builder.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_states.dart';
import 'package:our_store/views/home/ui/widgets/category_builders.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CategoriesCubit categoryCubit;
  late DiscountsViewCubit productCubit;

  @override
  void initState() {
    super.initState();
    categoryCubit = context.read<CategoriesCubit>()..getCategories();
    productCubit = context.read<DiscountsViewCubit>()..getDiscountsView();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      child: RefreshIndicator(
        onRefresh: () async {
          await categoryCubit.getCategories(force: true);
          await productCubit.getDiscountsView(force: true);
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
            BlocConsumer<DiscountsViewCubit, DiscountsViewState>(
              listener: (context, state) {
                if (state is DiscountsViewFaluire) {
                  customSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is DiscountsViewLoading) {
                  return const CustomIndicator();
                } else if (state is DiscountsViewSuccess) {
                  return DiscountBuilder(
                    discountsViewModel: state.discountViewModel,
                  );
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
