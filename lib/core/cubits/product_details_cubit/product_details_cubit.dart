import 'package:bloc/bloc.dart';
import 'package:our_store/core/cubits/product_details_cubit/product_details_state.dart';
import 'package:our_store/core/models/product_details_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final SupabaseService service = SupabaseService();
  late List<ProductDetailsModel> productDetailsModel;

  final Map<String, List<ProductDetailsModel>> cache = {};

  Future<void> getProductDetails({required String id}) async {
    if (cache.containsKey(id)) {
      emit(ProductDetailsSuccess(productDetailsModel: cache[id]!));
      return;
    }
    emit(ProductDetailsLoading());
    try {
      productDetailsModel = await service.fetchProductDetails(id: id);
      cache[id] = productDetailsModel;
      emit(ProductDetailsSuccess(productDetailsModel: productDetailsModel));
    } catch (e) {
      emit(ProductDetailsFaluire(message: e.toString()));
    }
  }
}
