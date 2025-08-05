import 'package:bloc/bloc.dart';
import 'package:our_store/views/home/logic/cubits/discounts_cubit/discounts_state.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

class DiscountsCubit extends Cubit<DiscountsState> {
  DiscountsCubit() : super(DiscountsInitial());
  final SupabaseService service = SupabaseService();
  late List<DiscountModel> product;

  bool hasFetchedProducts = false;

  Future<void> getDiscounts({
    bool force = false,
    required String parameters,
  }) async {
    if (!force && hasFetchedProducts) return;
    emit(DiscountLoading());
    try {
      product = await service.fetchDiscounts(parametersValue: parameters);
      hasFetchedProducts = true;
      emit(DiscountSuccess(discountModel: product));
    } catch (e) {
      emit(DiscountFaluire(message: e.toString()));
    }
  }
}
