
import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/product.dart';

class CustomList extends StatelessWidget {
  const CustomList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Product(),
      separatorBuilder: (context, index) => SizedBox(height: 15,),
      itemCount: 6,
    );
  }
}
