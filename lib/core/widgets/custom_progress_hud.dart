import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:our_store/core/app_colors.dart';

class CustomProgressHud extends StatelessWidget {
  const CustomProgressHud({
    super.key,
    required this.loading,
    required this.child,
  });
  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
        ),
        child: child,
      ),
    );
  }
}
