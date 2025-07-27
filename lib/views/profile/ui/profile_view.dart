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

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AuthCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AuthCubit>()..getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is SuccessLogout) {
          customSnackBar(context, 'Success logout');
          navigateToWithoutBack(context, LoginView());
        } else if (state is FailureLogout) {
          customSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          loading: state is LoadingLogout || state is LoadingUserDataGot,
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
                    Text(
                      cubit.userModel?.name ?? 'my name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cubit.userModel?.email ?? 'email@gmail.com',
                      style: const TextStyle(
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
