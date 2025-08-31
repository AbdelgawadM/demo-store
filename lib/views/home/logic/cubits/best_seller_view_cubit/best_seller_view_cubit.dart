import 'package:bloc/bloc.dart';
import 'package:our_store/views/home/logic/cubits/best_seller_view_cubit/best_seller_view_states.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';

class BestSellerViewCubit extends Cubit<BestsellerViewState> {
  BestSellerViewCubit() : super(BestSellerInitial());
  final SupabaseService service = SupabaseService();
  late List<ProductViewModel> productViewModel;

  bool hasFetchedProducts = false;
  Future<void> refresh() async {
    productViewModel = await service.fetchBestSellerView();
    emit(BestSellerViewSuccess(productViewModel: productViewModel));
  }

  Future<void> getBestSellerView() async {
    if (hasFetchedProducts) return;
    emit(BestSellerViewLoading());
    try {
      productViewModel = await service.fetchBestSellerView();
      hasFetchedProducts = true;
      emit(BestSellerViewSuccess(productViewModel: productViewModel));
    } catch (e) {
      emit(BestSellerViewFaluire(message: e.toString()));
    }
  }
}
