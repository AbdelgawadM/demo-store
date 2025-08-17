import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_store/core/models/favorite_model.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final SupabaseService supabaseService = SupabaseService();
  List<FavoriteModel> favoriteModel = [];
  bool hasFetchedFavourites = false;
  Future<void> refresh({required String userId}) async {
    favoriteModel = await supabaseService.fetchFavorites(userId: userId);
    emit(FavoriteSuccess(favoriteModel: favoriteModel));
  }

  Future<void> getFavorites({required String userId}) async {
    if (hasFetchedFavourites) return;
    emit(FavoriteLoading());
    try {
      favoriteModel = await supabaseService.fetchFavorites(userId: userId);
      hasFetchedFavourites = true;
      emit(FavoriteSuccess(favoriteModel: favoriteModel));
    } catch (e) {
      emit(FavoriteFaliure(message: e.toString()));
    }
  }

  Future<void> addToFavorites({
    required String userId,
    required String productId,
    required ProductViewModel productViewModel,
  }) async {
    favoriteModel.add(FavoriteModel(productViewModel: productViewModel));
    try {
      await supabaseService.addFavorite(productId: productId, userId: userId);
      emit(FavoriteAddedSuccess());
      emit(FavoriteSuccess(favoriteModel: favoriteModel));
    } catch (e) {
      emit(FavoriteAddedFaliure(message: e.toString()));
    }
  }
}
