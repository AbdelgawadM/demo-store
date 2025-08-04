part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInital extends CategoriesState {}

final class CategorySuccess extends CategoriesState {
  final List<CategoryModel> categoryModel;

  CategorySuccess({required this.categoryModel});
}

final class CategoryLoading extends CategoriesState {}

final class CategoryFaluire extends CategoriesState {
  final String message;

  CategoryFaluire({required this.message});
}

final class CategoryEmpty extends CategoriesState {}
