import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInital());
  final SupabaseService service = SupabaseService();
  late List<CategoryModel> category;

  bool hasFetchedCategories = false;
  Future<void> refresh() async {
    category = await service.fetchCategories();
    emit(CategorySuccess(categoryModel: category));
  }

  Future<void> getCategories() async {
    if (hasFetchedCategories) return;
    emit(CategoryLoading());
    try {
      category = await service.fetchCategories();
      hasFetchedCategories = true;
      emit(CategorySuccess(categoryModel: category));
    } catch (e) {
      emit(CategoryFaluire(message: e.toString()));
    }
  }
}
