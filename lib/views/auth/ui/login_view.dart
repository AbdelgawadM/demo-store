import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';
import 'package:our_store/views/auth/ui/widgets/custem_text_btn.dart';
import 'package:our_store/views/auth/ui/widgets/custom_row.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24),
                Text(
                  'Welcome to our Market',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Card(
                  margin: EdgeInsets.all(24),
                  color: AppColors.kWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 20,
                      children: [
                        CustomTextField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          isHidden: isHidden,
                          label: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          sufIcon: IconButton(
                            onPressed: () {
                              isHidden = !isHidden;
                              setState(() {});
                            },
                            icon: Icon(Icons.visibility_off),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextBtn(
                              text: 'Forget Password?',
                              onTap: () {},
                            ),
                          ],
                        ),
                        CustomRow(data: 'Login', onPressed: () {}),
                        CustomRow(data: 'Login With Google', onPressed: () {}),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have Account ?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            CustomTextBtn(text: 'Sign up'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
