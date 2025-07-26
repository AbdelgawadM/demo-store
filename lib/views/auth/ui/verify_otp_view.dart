import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/reset_password_view.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

// ignore: must_be_immutable
class VerifyOtpView extends StatelessWidget {
  VerifyOtpView({super.key, required this.email});
  final String email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is SuccessVerfying) {
              customSnackBar(context, 'Correct Otp');
              navigateTo(context, const ResetPasswordView());
            } else if (state is FailureVerfying) {
              customSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return CustomProgressHud(
              loading: state is LoadingVerfying,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  const TitleTxtField(text: 'verify Otp'),
                  CustomCard(
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          CustomTextField(
                            controller: controller,
                            label: 'OTP',
                            keyboardType: TextInputType.number,
                          ),
                          CustomButton(
                            label: 'Submit',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.verifyOTP(
                                  email: email,
                                  otpCode: controller.text,
                                );
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
