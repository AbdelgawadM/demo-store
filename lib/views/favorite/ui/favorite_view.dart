import 'package:flutter/material.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Center(child: TitleTxtField(text: 'Your Favorite Products')),
        //  CustomList()
      ],
    );
  }
}
