import 'package:bloc/bloc.dart';
import 'package:our_store/core/cubits/product_view_cubit/product_view_states.dart';
import 'package:our_store/core/models/product_view_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

class ProductViewCubit extends Cubit<ProductViewState> {
  ProductViewCubit() : super(ProductViewInitial());
  final SupabaseService service = SupabaseService();
  late List<ProductViewModel> productsViewModel;

  final Map<String, List<ProductViewModel>> cache = {};
  void refresh() async {
    cache.clear();
  }

  Future<void> getProductView({required String id}) async {
    if (cache.containsKey(id)) {
      emit(ProductViewSuccess(productViewModel: cache[id]!));
      return;
    }
    emit(ProductViewLoading());
    try {
      productsViewModel = await service.fetchProductView(id: id);
      cache[id] = productsViewModel;
      emit(ProductViewSuccess(productViewModel: productsViewModel));
    } catch (e) {
      emit(ProductViewFaluire(message: e.toString()));
    }
  }
}
