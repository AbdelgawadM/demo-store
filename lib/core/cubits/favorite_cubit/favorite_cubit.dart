import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_store/core/models/favorite_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final SupabaseService supabaseService = SupabaseService();
  late List<FavoriteModel> favoriteModel;

  Future<void> getFavorites({required String userId}) async {
    emit(FavoriteLoading());
    try {
      favoriteModel = await supabaseService.fetchFavorites(userId: userId);
      emit(FavoriteSuccess(favoriteModel: favoriteModel));
    } catch (e) {
      emit(FavoriteFaliure(message: e.toString()));
    }
  }

  
}
