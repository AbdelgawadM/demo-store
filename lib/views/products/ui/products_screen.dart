import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_cubit.dart';
import 'package:our_store/views/products/logic/cubits/product_view_cubit/product_view_states.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/core/widgets/product_builder.dart';
import 'package:our_store/views/home/logic/models/category_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.categoryModel,
  });
  final CategoryModel categoryModel;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductViewCubit productViewCubit;
  @override
  void initState() {
    super.initState();
    productViewCubit = context.read<ProductViewCubit>()
      ..getProductView(categoryId: widget.categoryModel.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryModel.label),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<ProductViewCubit, ProductViewState>(
        builder: (context, state) {
          return state is ProductViewSuccess
              ? ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    const SizedBox(height: 10),
                    ProductBuilder(productViewModel: state.productViewModel),
                    const SizedBox(height: 20),
                  ],
                )
              : const CustomIndicator();
        },
      ),
    );
  }
}
