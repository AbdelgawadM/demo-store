import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/functions/navigate_to.dart';
import 'package:our_store/core/widgets/custom_progress_hud.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/auth/ui/login_view.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/profile/ui/my_orders_view.dart';
import 'package:our_store/views/profile/ui/edit_name_view.dart';
import 'package:our_store/views/profile/ui/widgets/custom_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is Success) {
          customSnackBar(context, 'Success Login');
          navigateToWithoutBack(context, LoginView());
        } else if (state is Failure) {
          customSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return CustomProgressHud(
          loading: state is Loading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: AppColors.kWhiteColor,
                      radius: 60,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'My Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'email@gmail.com',
                      style: TextStyle(
                        color: AppColors.kGreyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),

                    CustomTile(
                      title: 'Edit Name',
                      icon: Icons.person,
                      onTap: () {
                        navigateTo(context, const EditNameView());
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTile(
                      title: 'My Orders',
                      icon: Icons.shopping_basket,
                      onTap: () {
                        navigateTo(context, const MyOrdersView());
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTile(
                      title: 'Log Out',
                      icon: Icons.logout,
                      onTap: () {
                        cubit.logOut();
                        customSnackBar(context, 'success log Out');
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
