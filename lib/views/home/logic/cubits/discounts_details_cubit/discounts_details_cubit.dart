import 'package:bloc/bloc.dart';
import 'package:our_store/views/home/logic/cubits/discounts_details_cubit/discounts_details_state.dart';
import 'package:our_store/core/services/supabase_service.dart';
import 'package:our_store/views/home/logic/models/discounts_details_model.dart';

class DiscountsDetailsCubit extends Cubit<DiscountsDetailsState> {
  DiscountsDetailsCubit() : super(DiscountsDetailsInitial());
  final SupabaseService service = SupabaseService();
  late List<DiscountsDetailsModel> discountsDetailsModel;

  final Map<String, List<DiscountsDetailsModel>> cache = {};

  Future<void> getDiscountsDetails({required String id}) async {
    emit(DiscountsDetailsLoading());
    if (cache.containsKey(id)) {
      emit(DiscountsDetailsSuccess(discountDetailsModel: cache[id]!));
      return;
    }

    emit(DiscountsDetailsLoading());
    try {
      discountsDetailsModel = await service.fetchDiscountsDetails(id: id);
      cache[id] = discountsDetailsModel;
      emit(
        DiscountsDetailsSuccess(discountDetailsModel: discountsDetailsModel),
      );
    } catch (e) {
      emit(DiscountsDetailsFaluire(message: e.toString()));
    }
  }
}
