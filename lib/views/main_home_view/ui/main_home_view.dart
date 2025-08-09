import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/home/logic/cubits/category_cubit/categories_cubit.dart';
import 'package:our_store/views/favorite/ui/favorite_view.dart';
import 'package:our_store/views/home/logic/cubits/discounts_view_cubit/discounts_view_cubit.dart';
import 'package:our_store/views/home/ui/home_view.dart';
import 'package:our_store/views/profile/ui/profile_view.dart';
import 'package:our_store/views/store/ui/store_view.dart';

// ignore: must_be_immutable
class MainHomeView extends StatelessWidget {
  MainHomeView({super.key});

  final RxInt _selectedIndex = 0.obs;

  final List<Widget> views = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => DiscountsViewCubit()),
      ],
      child: Scaffold(
        body: SafeArea(child: Obx(() => views[_selectedIndex.value])),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8,
              ),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: AppColors.kWhiteColor,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.kPrimaryColor,
                color: Colors.black26,
                tabs: const [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.store, text: 'Store'),
                  GButton(icon: Icons.favorite, text: 'favourite'),
                  GButton(icon: Icons.person, text: 'Profile'),
                ],
                selectedIndex: _selectedIndex.value,
                onTabChange: (index) {
                  _selectedIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
