import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/views/favorite/logic/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/product_builder.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';
import 'package:our_store/views/favorite/widgets/empty_favourites_widget.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late FavoriteCubit favoriteCubit = context.read<FavoriteCubit>();
  late String userId = context.read<AuthCubit>().client.auth.currentUser!.id;

  @override
  void initState() {
    super.initState();
    favoriteCubit.getFavorites(userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await favoriteCubit.refresh(userId: userId);
      },
      child: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteRemovedSuccess) {
            customSnackBar(context, 'removing done');
          }
          if (state is FavoriteRemovedFaliure) {
            customSnackBar(context, 'favourite not removed: ${state.message}');
          }
          if (state is FavoriteLoadedFaliure) {
            customSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingsState) {
            return const CustomIndicator();
          } else if (state is FavoriteLoadedEmpty) {
            return const EmptyFavoritesWidget();
          } else if (state is FavoriteSuccessState) {
            // now Dart knows the type
            return ListView(
              children: [
                const Center(
                  child: TitleTxtField(text: 'Your Favorite Products'),
                ),
                ProductBuilder(
                  productViewModel: state.favoriteModel
                      .map((fav) => fav.productViewModel)
                      .toList(),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Error has Ocurred'));
          }
        },
      ),
    );
  }
}
