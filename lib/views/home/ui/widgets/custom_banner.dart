import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_store/core/widgets/custom_button.dart';
import 'package:our_store/views/main_home_view/logic/cubit/nav_bar_cubit.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.all(Radius.circular(15)),
            child: Image.asset('assets/images/banner.png', fit: BoxFit.contain),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  const Text(
                    'Get Your Special Sale Up To 40%',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    label: 'Shop Now',
                    backColor: Colors.white,
                    frontColor: Colors.black,
                    onPressed: () {
                      context.read<NavBarCubit>().changeIndex(1);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
