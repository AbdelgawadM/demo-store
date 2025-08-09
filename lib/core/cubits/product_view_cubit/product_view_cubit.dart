import 'package:bloc/bloc.dart';
import 'package:our_store/core/cubits/product_view_cubit/product_view_states.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

class ProductViewCubit extends Cubit<ProductViewState> {
  ProductViewCubit() : super(ProductViewInitial());
  final SupabaseService service = SupabaseService();
  late List<ProductViewModel> productsViewModel;
  int? selectedIndex;

  final Map<String, List<ProductViewModel>> cache = {};

  Future<void> getProductView({required String category}) async {
    if (cache.containsKey(category)) {
      emit(ProductViewSuccess(producttViewModel: cache[category]!));
      return;
    }
    emit(ProductViewLoading());
    try {
      productsViewModel = await service.fetchProductView(category: category);
      cache[category] = productsViewModel;
      emit(ProductViewSuccess(producttViewModel: productsViewModel));
    } catch (e) {
      emit(ProductViewFaluire(message: e.toString()));
    }
  }
}
