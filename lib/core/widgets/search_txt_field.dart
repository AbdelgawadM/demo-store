
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';

class SearchTxtField extends StatelessWidget {
  const SearchTxtField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: Text(
        'Search in Market...',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      keyboardType: TextInputType.webSearch,
      fillColor: AppColors.kWhiteColor,
      sufIcon: ElevatedButton.icon(
        onPressed: () {},
        label: Icon(Icons.search, color: AppColors.kWhiteColor, size: 24),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
      ),
    );
  }
}
