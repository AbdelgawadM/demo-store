import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios),
      minLeadingWidth: 90,
      textColor: AppColors.kWhiteColor,
      tileColor: AppColors.kPrimaryColor,
      iconColor: AppColors.kWhiteColor,
      onTap: onTap,
    );
  }
}
