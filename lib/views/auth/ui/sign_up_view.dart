import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/login_view.dart';
import 'package:our_store/views/auth/ui/widgets/custem_text_btn.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_row.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';
import 'package:our_store/views/main_home_view/ui/main_home_view.dart';

// ignore: must_be_immutable
class SignUpView extends StatelessWidget {
  RxBool isHidden = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is SuccessSignUp) {
              customSnackBar(context, 'success registeration');
              navigateToWithoutBack(context, MainHomeView());
            } else if (state is FailureSignUp) {
              customSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return CustomProgressHud(
              loading: state is LoadingSignUp,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const TitleTxtField(text: 'Welcome To Our Store'),
                        CustomCard(
                           padding: const EdgeInsetsGeometry.all(16),
                    margin: const EdgeInsets.all(24),
                          child: Column(
                            spacing: 20,
                            children: [
                              CustomTextField(
                                controller: nameController,
                                label: 'Name',
                                keyboardType: TextInputType.name,
                              ),
                              CustomTextField(
                                controller: emailController,
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Obx(
                                () => CustomTextField(
                                  controller: passController,
                                  label: 'Password',
                                  keyboardType: TextInputType.visiblePassword,
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
                                ),
                              ),
                              CustomRow(
                                data: 'Sign UP',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.signUp(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                  }
                                },
                              ),
                              CustomRow(
                                data: 'Sign UP With Google',
                                onPressed: () {},
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already Have Account ?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  CustomTextBtn(
                                    text: 'Login',
                                    onTap: () {
                                      navigateToWithoutBack(context, LoginView());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
