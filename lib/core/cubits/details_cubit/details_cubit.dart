import 'package:bloc/bloc.dart';
import 'package:our_store/core/cubits/details_cubit/details_state.dart';
import 'package:our_store/core/models/details_model.dart';
import 'package:our_store/core/services/supabase_service.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());
  final SupabaseService service = SupabaseService();
  late List<DetailsModel> detailsModel;

  final Map<String, List<DetailsModel>> detailsCache = {};

  void refresh() async {
    detailsCache.clear();
  }

  Future<void> getProductDetails({required String productId}) async {
    if (detailsCache.containsKey(productId)) {
      emit(
        ProductDetailsSuccess(productDetailsModel: detailsCache[productId]!),
      );
      return;
    }
    emit(ProductDetailsLoading());
    try {
      detailsModel = await service.fetchProductDetails(productId: productId);
      detailsCache[productId] = detailsModel;
      emit(ProductDetailsSuccess(productDetailsModel: detailsModel));
    } catch (e) {
      emit(ProductDetailsFaluire(message: e.toString()));
    }
  }

  Future<void> getDiscountDetails({
    required String discountId,
    required String productId,
  }) async {
    if (detailsCache.containsKey(discountId)) {
      emit(
        DiscountDetailsSuccess(discountDetailsModel: detailsCache[discountId]!),
      );
      return;
    }
    emit(DiscountDetailsLoading());
    try {
      detailsModel = await service.fetchDiscountsDetails(productId: productId);
      detailsCache[discountId] = detailsModel;
      emit(DiscountDetailsSuccess(discountDetailsModel: detailsModel));
    } catch (e) {
      emit(DiscountDetailsFaluire(message: e.toString()));
    }
  }
}
