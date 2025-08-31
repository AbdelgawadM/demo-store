import 'package:bloc/bloc.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_states.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

class ProductViewCubit extends Cubit<ProductViewState> {
  ProductViewCubit() : super(ProductViewInitial());
  final SupabaseService service = SupabaseService();
  late List<ProductViewModel> productsViewModel;
 

  final Map<String, dynamic> productViewCache = {};
  Future<void> refresh() async {
    productViewCache.clear();
  }

  Future<void> getProductView({required String categoryId}) async {
    if (productViewCache.containsKey(categoryId)) {
      emit(ProductViewSuccess(productViewModel: productViewCache[categoryId]!));
      return;
    }
    emit(ProductViewLoading());
    try {
      productsViewModel = await service.fetchProductView(
        categoryId: categoryId,
      );
      productViewCache[categoryId] = productsViewModel;
      emit(ProductViewSuccess(productViewModel: productsViewModel));
    } catch (e) {
      emit(ProductViewFaluire(message: e.toString()));
    }
  }
}
