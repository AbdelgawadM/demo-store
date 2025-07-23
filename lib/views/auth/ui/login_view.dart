import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/forget_view.dart';
import 'package:our_store/views/auth/ui/widgets/custem_text_btn.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_row.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';
import 'package:our_store/views/auth/ui/widgets/title_txt_field.dart';
import 'package:our_store/views/main_home_view/ui/main_home_view.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});

  RxBool isHidden = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is Success) {
              customSnackBar(context, 'Success Login');
              navigateToWithoutBack(context, MainHomeView());
            } else if (state is Failure) {
              customSnackBar(context, state.message);
            }
          },

          builder: (context, state) {
            AuthCubit cubit = context.read<AuthCubit>();
            return CustomProgressHud(
              loading: state is Loading,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleTxtField(text: 'Welcome To Our Store'),
                      CustomCard(
                        child: Form(
                          key: formKey,
                          child: Column(
                            spacing: 20,
                            children: [
                              CustomTextField(
                                controller: emailController,
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Obx(
                                () => CustomTextField(
                                  controller: passController,
                                  isHidden: isHidden.value,
                                  label: 'Password',
                                  keyboardType: TextInputType.visiblePassword,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomTextBtn(
                                    text: 'Forget Password?',
                                    onTap: () {
                                      navigateTo(context, ForgetView());
                                    },
                                  ),
                                ],
                              ),
                              CustomRow(
                                data: 'Login',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.login(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                  }
                                },
                              ),
                              CustomRow(
                                data: 'Login With Google',
                                onPressed: () {},
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dont have Account ?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  CustomTextBtn(
                                    text: 'Sign up',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
