import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:our_store/views/favorite/logic/models/favorite_model.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final SupabaseService supabaseService = SupabaseService();
  List<FavoriteModel> favoriteModel = [];
  bool hasFetchedFavourites = false;

  // bool isProductFav(ProductViewModel productViewModel) {
  //   return productViewModel.isFav!;
  // }

  Future<void> getFavorites() async {
    if (hasFetchedFavourites) return;
    emit(FavoriteLoadedLoading());
    try {
      favoriteModel = await supabaseService.fetchFavorites();
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
    final bool isFavorite = productViewModel
        .isFav!; // ask it if this product id is in favModelList(isFav)
    if (!isFavorite ) {
      //if not favourite
      emit(FavoriteAddedLoading());
      try {
        await supabaseService.addFavorite(productId: productId); //server
        favoriteModel.add(FavoriteModel(productViewModel: productViewModel));//my model
        // productViewModel.isFav = true;
        emit(FavoriteAddedSuccess(favoriteModel));
      } catch (e) {
        emit(FavoriteAddedFaliure(message: e.toString()));
      }
    } else {
      emit(FavoriteRemovedLoading());
      try {
        await supabaseService.removeFavorite(productId: productId);
        favoriteModel.removeWhere(
          (fav) => fav.productViewModel.productId == productId,
        );
        // productViewModel.isFav = false;
        emit(FavoriteRemovedSuccess(favoriteModel));
        chechIfEmpty(favoriteModel);
      } catch (e) {
        emit(FavoriteRemovedFaliure(message: e.toString()));
        // emit(FavoriteRemovedSuccess(favoriteModel)); //message success appears
      }
    }
  }

  void chechIfEmpty(List<FavoriteModel> favorite) {
    if (favorite.isEmpty) {
      emit(FavoriteLoadedEmpty());
    }
  }
}
