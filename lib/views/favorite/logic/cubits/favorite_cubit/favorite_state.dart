part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

//************************************************************************

abstract class FavoriteSuccessState extends FavoriteState {
  final List<FavoriteModel> favoriteModel;
  FavoriteSuccessState(this.favoriteModel);
}

abstract class FavoriteLoadingsState extends FavoriteState {}

//************************************************************************

class FavoriteLoadedSuccess extends FavoriteSuccessState {
  FavoriteLoadedSuccess(super.favoriteModel);
}

final class FavoriteLoadedLoading extends FavoriteLoadingsState {}

final class FavoriteLoadedEmpty extends FavoriteState {}

final class FavoriteLoadedFaliure extends FavoriteState {
  final String message;

  FavoriteLoadedFaliure({required this.message});
}

//************************************************************************

class FavoriteAddedSuccess extends FavoriteSuccessState {
  FavoriteAddedSuccess(super.favoriteModel);
} //just informing

final class FavoriteAddedLoading extends FavoriteLoadingsState {}

final class FavoriteAddedFaliure extends FavoriteState {
  final String message;

  FavoriteAddedFaliure({required this.message});
}

//************************************************************************

class FavoriteRemovedSuccess extends FavoriteSuccessState {
  FavoriteRemovedSuccess(super.favoriteModel);
} //just informing

final class FavoriteRemovedLoading extends FavoriteLoadingsState {}

final class FavoriteRemovedFaliure extends FavoriteState {
  final String message;

  FavoriteRemovedFaliure({required this.message});
}

//************************************************************************
