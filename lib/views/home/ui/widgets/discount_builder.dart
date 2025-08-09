import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/discount_details/ui/discount_details_view.dart';
import 'package:our_store/views/home/ui/widgets/discountProduct.dart';
import 'package:our_store/views/home/logic/cubits/discounts_details_cubit/discounts_details_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_details_cubit/discounts_details_state.dart';
import 'package:our_store/views/home/logic/models/discounts_details_model.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';

class DiscountBuilder extends StatelessWidget {
  const DiscountBuilder({
    super.key,
    required this.discountsViewModel,
  });

  final List<DiscountsViewModel> discountsViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscountsDetailsCubit(),
      child: BlocConsumer<DiscountsDetailsCubit, DiscountsDetailsState>(
        listener: (context, state) {
          if (state is DiscountsDetailsSuccess) {
            final DiscountsDetailsCubit cubit = context
                .read<DiscountsDetailsCubit>();
            final List<DiscountsDetailsModel> discountsDetailsModel =
                state.discountDetailsModel;

            final selected = cubit.selectedIndex;

            navigateTo(
              context,
              DiscountDetailsView(
                discountsViewModel: discountsViewModel[selected!],
                discountsDetailsModel: discountsDetailsModel.first,
              ),
            );
          }
        },
        builder: (context, state) {
          return state is DiscountsDetailsLoading
              ? const CustomIndicator()
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Discountproduct(
                    discountsViewModel: discountsViewModel[index],
                    onTap: () {
                      final DiscountsDetailsCubit cubit = context
                          .read<DiscountsDetailsCubit>();
                      cubit.selectedIndex = index;
                      cubit.getDiscountsDetails(
                        id: discountsViewModel[index].id,
                      );
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: discountsViewModel.length,
                );
        },
      ),
    );
  }
}
