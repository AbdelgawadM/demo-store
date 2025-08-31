import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:our_store/views/favorite/logic/models/favorite_model.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final ProductViewCubit productViewCubit = ProductViewCubit();
  final SupabaseService supabaseService = SupabaseService();
  List<FavoriteModel> favoriteModel = [];
  bool hasFetchedFavourites = false;

  // central place for fav state
  final Map<String, bool> favoritesState = {};

  bool isProductFav(String productId) {
    return favoritesState[productId] ?? false;
  }

  Future<void> getFavorites() async {
    if (hasFetchedFavourites) return;
    emit(FavoriteLoadedLoading());
    try {
      favoriteModel = await supabaseService.fetchFavorites();
      for (final fav in favoriteModel) {
        favoritesState[fav.productViewModel.productId] = true;
      }
      hasFetchedFavourites = true;
      emit(FavoriteLoadedSuccess(favoriteModel));
      chechIfEmpty(favoriteModel);
    } catch (e) {
      emit(FavoriteLoadedFaliure(message: e.toString()));
    }
  }

  Future<void> toggleFavorites({
    required String productId,
    required ProductViewModel productViewModel,
  }) async {
    final bool isFavorite = isProductFav(productId);

    if (isFavorite) {
      emit(FavoriteRemovedLoading());
      try {
        await supabaseService.removeFavorite(productId: productId);
        favoriteModel.removeWhere(
          (fav) => fav.productViewModel.productId == productId,
        );
        favoritesState[productId] = false;
        emit(FavoriteRemovedSuccess(favoriteModel));
        chechIfEmpty(favoriteModel);
      } catch (e) {
        emit(FavoriteRemovedFaliure(message: e.toString()));
        // emit(FavoriteRemovedSuccess(favoriteModel)); //message success appears
      }
    } else {
      emit(FavoriteAddedLoading());
      try {
        await supabaseService.addFavorite(productId: productId); //server
        favoriteModel.add(
          FavoriteModel(productViewModel: productViewModel),
        ); //my model
        favoritesState[productId] = true;
        emit(FavoriteAddedSuccess(favoriteModel));
      } catch (e) {
        emit(FavoriteAddedFaliure(message: e.toString()));
      }
    }
  }

  void chechIfEmpty(List<FavoriteModel> favorite) {
    if (favorite.isEmpty) {
      emit(FavoriteLoadedEmpty());
    }
  }
}
