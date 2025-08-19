import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_store/views/favorite/logic/models/favorite_model.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final SupabaseService supabaseService = SupabaseService();
  List<FavoriteModel> favoriteModel = [];
  List<String> cacheIds = [];
  bool hasFetchedFavourites = false;
  bool isFavColor = false;

  Future<void> refresh({required String userId}) async {
    favoriteModel = await supabaseService.fetchFavorites(userId: userId);
    if (favoriteModel.isEmpty) {
      emit(FavoriteLoadedEmpty());
      return;
    }
    emit(FavoriteLoadedSuccess(favoriteModel));
  }

  Future<void> getFavorites({required String userId}) async {
    if (hasFetchedFavourites) return;
    emit(FavoriteLoadedLoading());
    try {
      favoriteModel = await supabaseService.fetchFavorites(userId: userId);
      hasFetchedFavourites = true;
      if (favoriteModel.isEmpty) {
        emit(FavoriteLoadedEmpty());
        return;
      }
      emit(FavoriteLoadedSuccess(favoriteModel));
    } catch (e) {
      emit(FavoriteLoadedFaliure(message: e.toString()));
    }
  }

  Future<void> toggleFavorites({
    required String userId,
    required String productId,
    required ProductViewModel productViewModel,
  }) async {
    if (!cacheIds.contains(productId)) {
      //if not favourite
      emit(FavoriteAddedLoading());
      try {
        await supabaseService.addFavorite(productId: productId, userId: userId);
        favoriteModel.add(FavoriteModel(productViewModel: productViewModel));
        cacheIds.add(productId);
        isFavColor = true;
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
        cacheIds.remove(productId);
        isFavColor = false;
        if (favoriteModel.isEmpty) {
          emit(FavoriteLoadedEmpty());
          return;
        }
        emit(FavoriteRemovedSuccess(favoriteModel));
      } catch (e) {
        emit(FavoriteRemovedFaliure(message: e.toString()));
      }
    }
  }

 
}
