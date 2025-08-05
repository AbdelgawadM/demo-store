import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/product.dart';
import 'package:our_store/views/home/logic/cubits/discounts_cubit/discounts_cubit.dart';
import 'package:our_store/views/home/logic/cubits/discounts_cubit/discounts_state.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';
import 'package:our_store/views/product_details/ui/products_details.dart';

class DiscountBuilder extends StatelessWidget {
   DiscountBuilder({
    super.key,
    required this.mainDiscounts,
    this.restDiscounts,
  });

  final List<DiscountModel> mainDiscounts;
  List<DiscountModel>? restDiscounts;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountsCubit, DiscountsState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Product(
            mainDiscounts: mainDiscounts[index].product,
            index: index,
            onTap: () {
              context.read<DiscountsCubit>().getDiscounts(
                parameters: 'description',
              );
              if (state is DiscountSuccess) {
                restDiscounts = state.discountModel;
              }
              navigateTo(
                context,
                ProductDetails(
                  mainDiscounts: mainDiscounts[index].product,
                  restDiscounts: restDiscounts![index].product,
                ),
              );
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: mainDiscounts.length,
        );
      },
    );
  }
}
