import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/core/functions/custom_snackbar.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit.dart';
import 'package:our_store/views/auth/logic/cubit/auth_cubit_state.dart';
import 'package:our_store/views/home/ui/widgets/icon_container.dart';

class HomeRow extends StatelessWidget {
  const HomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: AppColors.kWhiteColor,
              radius: 25,
              child: Icon(HugeIcons.strokeRoundedMale02, size: 25),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<AuthCubit, AuthCubitState>(
                  listener: (context, state) {
                    if (state is FailureUserDataGot) {
                      customSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return state is SuccessUserDataGot
                        ? Text(
                            'Hello, ${state.userModel.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          )
                        : const CustomIndicator();
                  },
                ),
                const SizedBox(height: 3),
                const Text(
                  'Good Morning!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Row(
          children: [
            IconContainer(icon: HugeIcons.strokeRoundedNotification02),
            SizedBox(width: 5),
            IconContainer(icon: HugeIcons.strokeRoundedShoppingBag03),
          ],
        ),
      ],
    );
  }
}
