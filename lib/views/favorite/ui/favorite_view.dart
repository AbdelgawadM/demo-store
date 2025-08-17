import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/product_builder.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

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
      child: ListView(
        children: [
          const Center(child: TitleTxtField(text: 'Your Favorite Products')),
          BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              if (state is FavoriteAddedFaliure) {
                customSnackBar(
                  context,
                  'favourite not added: ${state.message}',
                );
              }
              if (state is FavoriteFaliure) {
                customSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return const CustomIndicator();
              } else if (state is FavoriteSuccess) {
                return ProductBuilder(
                  productViewModel: state.favoriteModel
                      .map((fav) => fav.productViewModel)
                      .toList(),
                );
              } else {
                return const Center(child: Text('Error has Ocurred'));
              }
            },
          ),
        ],
      ),
    );
  }
}
