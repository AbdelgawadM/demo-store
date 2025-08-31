import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/favorite/ui/favorite_view.dart';
import 'package:our_store/views/home/logic/cubits/category_cubit/categories_cubit.dart';
import 'package:our_store/views/home/ui/home_view.dart';
import 'package:our_store/views/main_home_view/logic/cubit/nav_bar_cubit.dart';
import 'package:our_store/views/profile/ui/profile_view.dart';
import 'package:our_store/views/sale/ui/sale_view.dart';

// ignore: must_be_immutable
class MainHomeView extends StatelessWidget {
  MainHomeView({super.key});

  final List<Widget> views = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CategoriesCubit())],
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final NavBarCubit navBarCubit = context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(child: views[navBarCubit.currentIndex]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  ),
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
                    duration: const Duration(milliseconds: 600),
                    tabBackgroundColor: AppColors.kPrimaryColor,
                    color: Colors.black26,
                    tabs: const [
                      GButton(
                        icon: HugeIcons.strokeRoundedHome05,
                        text: 'Home',
                      ),
                      GButton(
                        icon: HugeIcons.strokeRoundedDiscountTag01,
                        text: 'Sale',
                      ),
                      GButton(
                        icon: HugeIcons.strokeRoundedFavourite,
                        text: 'Favourite',
                      ),
                      GButton(
                        icon: HugeIcons.strokeRoundedMale02,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: navBarCubit.currentIndex,
                    onTabChange: (index) {
                      navBarCubit.changeIndex(index);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
