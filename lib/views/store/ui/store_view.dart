import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/search_txt_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: const [
          Center(child: TitleTxtField(text: 'Welcome TO Our Store')),
          SearchTxtField(),
          SizedBox(height: 20),
          // CustomList(),
        ],
      ),
    );
  }
}
