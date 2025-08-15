import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/cubits/details_cubit/details_cubit.dart';
import 'package:our_store/core/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/views/home/logic/cubits/category_cubit/categories_cubit.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_states.dart';
import 'package:our_store/views/home/ui/widgets/discount_builder.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/home/ui/widgets/category_builders.dart';
import 'package:our_store/views/home/ui/widgets/headings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CategoriesCubit categoryCubit;
  late DiscountsViewCubit discountsViewCubit;

  @override
  void initState() {
    super.initState();
    categoryCubit = context.read<CategoriesCubit>()..getCategories();
    discountsViewCubit = context.read<DiscountsViewCubit>()..getDiscountsView();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: RefreshIndicator(
        color: AppColors.kPrimaryColor,
        backgroundColor: AppColors.kScaffoldColor,
        onRefresh: () async {
          await categoryCubit.refresh();
          await discountsViewCubit.refresh();
          context.read<ProductViewCubit>().refresh();
          context.read<DetailsCubit>().refresh();
        },
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const SearchTxtField(),
            const SizedBox(height: 10),
            const Image(image: AssetImage('assets/images/buy.jpg')),
            const Headings(title: 'Categories'),
            const SizedBox(height: 5),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const CustomIndicator();
                } else if (state is CategorySuccess) {
                  return SizedBox(
                    height: 140,
                    child: CategoryBuilder(categories: state.categoryModel),
                  );
                } else {
                  return const Center(child: Text('Error has Ocurred'));
                }
              },
            ),
            const SizedBox(height: 5),
            const Headings(title: 'Products On sale'),
            const SizedBox(height: 10),
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
