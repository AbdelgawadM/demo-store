import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/login_view.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  RxBool isHidden = true.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            if (state is SuccessUpdating) {
              customSnackBar(context, 'sucess update');
              cubit.logOut();
              navigateToWithoutBack(context, LoginView());
            } else if (state is FailureUpdating) {
              customSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return CustomProgressHud(
              loading: state is LoadingUpdating,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  const TitleTxtField(text: 'Enter your New Password'),
                  CustomCard(
                     padding: const EdgeInsetsGeometry.all(16),
                    margin: const EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          CustomTextField(
                            isHidden: isHidden.value,
                            sufIcon: IconButton(
                              onPressed: () {
                                isHidden.value = !isHidden.value;
                              },
                              icon: Icon(
                                isHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            controller: controller,
                            label: 'New Password',
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          CustomButton(
                            label: 'Submit',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updatePassword(controller.text);
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
