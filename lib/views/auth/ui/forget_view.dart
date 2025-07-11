import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

class ForgetView extends StatelessWidget {
  const ForgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 48,),
            TitleTxtField(text: 'Enter your Email to reset Passwoed'),
            CustomCard(
              child: Column(
                spacing: 20,
                children: [
                  CustomTextField(
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomButton(label: 'Submit', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
