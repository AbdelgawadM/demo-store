import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

class ForgetView extends StatelessWidget {
  ForgetView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is SuccessEmailSent) {
              customSnackBar(context, 'Email Sent');
              // navigateTo(context, VerifyOtpView(email: controller.text));
            } else if (state is FailureEmailSent) {
              log(state.message);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return CustomProgressHud(
              loading: state is LoadingEmailSent,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  const TitleTxtField(
                    text: 'Enter your Email to reset Password',
                  ),
                  CustomCard(
                    padding: const EdgeInsetsGeometry.all(16),
                    margin: const EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          CustomTextField(
                            controller: controller,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CustomButton(
                            label: 'Submit',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.sendEmail(email: controller.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
