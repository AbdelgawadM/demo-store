import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/cubits/details_cubit/details_cubit.dart';
import 'package:our_store/core/widgets/product_builder.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/favorite/logic/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/views/home/logic/cubits/best_seller_view_cubit/best_seller_view_cubit.dart';
import 'package:our_store/views/home/logic/cubits/best_seller_view_cubit/best_seller_view_states.dart';
import 'package:our_store/views/home/ui/widgets/custom_banner.dart';
import 'package:our_store/views/home/ui/widgets/home_row.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/views/home/logic/cubits/category_cubit/categories_cubit.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/home/ui/widgets/category_builders.dart';
import 'package:our_store/views/home/ui/widgets/headings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final CategoriesCubit categoryCubit = context.read<CategoriesCubit>();
  late final BestSellerViewCubit bestSellerViewCubit = context
      .read<BestSellerViewCubit>();
  late final AuthCubit authCubit = context.read<AuthCubit>();
  late final FavoriteCubit favoriteCubit = context.read<FavoriteCubit>();

  @override
  void initState() {
    super.initState();
    authCubit.getUserData();
    favoriteCubit.getFavorites();
    categoryCubit.getCategories();
    bestSellerViewCubit.getBestSellerView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteAddedSuccess) {
          customSnackBar(context, 'Added To Favorites✅');
        }
        if (state is FavoriteRemovedSuccess) {
          customSnackBar(context, 'Removed From Favorites✅');
        }
        if (state is FavoriteAddedFaliure) {
          customSnackBar(context, 'favorite not added${state.message}');
          print('favorite not added${state.message}');
        }
        if (state is FavoriteRemovedFaliure) {
          customSnackBar(context, 'favorite not removed${state.message}');
          print('favorite not removed${state.message}');
        }
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: RefreshIndicator(
          color: AppColors.kPrimaryColor,
          backgroundColor: AppColors.kScaffoldColor,
          onRefresh: () async {
            await categoryCubit.refresh();
            bestSellerViewCubit.refresh();
            context.read<ProductViewCubit>().refresh();
            context.read<DetailsCubit>().refresh();
          },
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const HomeRow(),
              const SizedBox(height: 20),
              const SearchTxtField(),
              const SizedBox(height: 20),
              const Headings(title: 'Categories'),
              const SizedBox(height: 10),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CustomIndicator();
                  } else if (state is CategorySuccess) {
                    return SizedBox(
                      height: 60,
                      child: CategoryBuilder(categories: state.categoryModel),
                    );
                  } else {
                    return const Center(child: Text('Error has Ocurred'));
                  }
                },
              ),
              const SizedBox(height: 15),
              const CustomBanner(),
              const SizedBox(height: 15),
              const Headings(title: 'Best Seller'),
              const SizedBox(height: 10),
              BlocConsumer<BestSellerViewCubit, BestsellerViewState>(
                listener: (context, state) {
                  if (state is BestSellerViewFaluire) {
                    customSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is BestSellerViewLoading) {
                    return const CustomIndicator();
                  } else if (state is BestSellerViewSuccess) {
                    return ProductBuilder(
                      productViewModel: state.productViewModel,
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
      ),
    );
  }
}
