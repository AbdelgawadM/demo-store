import 'package:bloc/bloc.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_states.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';

class DiscountsViewCubit extends Cubit<DiscountsViewState> {
  DiscountsViewCubit() : super(DiscountsViewInitial());
  final SupabaseService service = SupabaseService();
  late List<DiscountsViewModel> discountsViewModel;

  bool hasFetchedProducts = false;
  Future<void> refresh() async {
    await service.fetchDiscountsView();
  }

  Future<void> getDiscountsView() async {
    if (hasFetchedProducts) return;
    emit(DiscountsViewLoading());
    try {
      discountsViewModel = await service.fetchDiscountsView();
      hasFetchedProducts = true;
      emit(DiscountsViewSuccess(discountViewModel: discountsViewModel));
    } catch (e) {
      emit(DiscountsViewFaluire(message: e.toString()));
    }
  }
}
