part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<FavoriteModel> favoriteModel;

  FavoriteSuccess({required this.favoriteModel});
}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteFaliure extends FavoriteState {
  final String message;

  FavoriteFaliure({required this.message});
}

// final class FavoriteAddedLoading extends FavoriteState {}

final class FavoriteAddedSuccess extends FavoriteState {}//just informing

final class FavoriteAddedFaliure extends FavoriteState {
  final String message;

  FavoriteAddedFaliure({required this.message});
}
