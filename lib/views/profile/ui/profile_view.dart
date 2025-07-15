import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/profile/ui/widgets/custom_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCard(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: AppColors.kWhiteColor,
                radius: 60,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 15),
              Text('My Name', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                'email@gmail.com',
                style: TextStyle(
                  color: AppColors.kGreyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),

              CustomTile(title: 'Edit Name', icon: Icons.person, onTap: () {}),
              SizedBox(height: 20),
              CustomTile(
                title: 'My Orders',
                icon: Icons.shopping_basket,
                onTap: () {},
              ),
              SizedBox(height: 20),
              CustomTile(title: 'Log Out', icon: Icons.logout, onTap: () {}),
              SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
