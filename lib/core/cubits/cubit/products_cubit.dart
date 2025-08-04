import 'package:bloc/bloc.dart';
import 'package:our_store/core/cubits/cubit/products_state.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final SupabaseService service = SupabaseService();
  late List<DiscountModel> product;

  bool hasFetchedProducts = false;

  Future<void> getDiscounts({bool force = false}) async {
    if (!force && hasFetchedProducts) return;
    emit(ProductLoading());
    try {
      product = await service.fetchDiscounts();
      hasFetchedProducts = true;
      emit(DiscountSuccess(discountModel: product));
    } catch (e) {
      emit(ProductFaluire(message: e.toString()));
    }
  }
}
