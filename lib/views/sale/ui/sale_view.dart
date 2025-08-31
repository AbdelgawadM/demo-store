import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';
import 'package:our_store/views/favorite/logic/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_states.dart';
import 'package:our_store/views/home/ui/widgets/discount_builder.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late final DiscountsViewCubit discountsViewCubit = context
      .read<DiscountsViewCubit>();
  @override
  void initState() {
    super.initState();
    discountsViewCubit.getDiscountsView();
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
        }
        if (state is FavoriteRemovedFaliure) {
          customSnackBar(context, 'favorite not removed${state.message}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
          color: AppColors.kPrimaryColor,
          backgroundColor: AppColors.kScaffoldColor,
          onRefresh: () async {
            discountsViewCubit.refresh();
          },
          child: ListView(
            children: [
              const Center(child: TitleTxtField(text: 'Grab It Now')),
              const SearchTxtField(),
              const SizedBox(height: 20),
              BlocBuilder<DiscountsViewCubit, DiscountsViewState>(
                builder: (context, state) {
                  if (state is DiscountsViewLoading) {
                    return const CustomIndicator();
                  } else if (state is DiscountsViewSuccess) {
                    return DiscountBuilder(
                      discountsViewModel: state.discountViewModel,
                    );
                  } else {
                    return const Text('error has occured');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
