import 'package:flutter/material.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/views/discount_details/ui/discount_details_view.dart';
import 'package:our_store/views/home/ui/widgets/discount_product.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';

class DiscountBuilder extends StatelessWidget {
  const DiscountBuilder({
    super.key,
    required this.discountsViewModel,
  });
  final List<DiscountsViewModel> discountsViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Discountproduct(
        discountsViewModel: discountsViewModel[index],
        onTap: () {
          navigateTo(
            context,
            DiscountDetailsView(
              discountsViewModel: discountsViewModel[index],
            ),
          );
        },
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: discountsViewModel.length,
    );
  }
}
