import 'package:flutter/material.dart';
import 'package:our_store/views/auth/ui/widgets/custem_text_btn.dart';
import 'package:our_store/views/auth/ui/widgets/custom_card.dart';
import 'package:our_store/views/auth/ui/widgets/custom_row.dart';
import 'package:our_store/views/auth/ui/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => SignUpViewMyWidgetState();
}

class SignUpViewMyWidgetState extends State<SignUpView> {
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
                  'Welcome To Our Store',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                CustomCard(
                  child: Column(
                    spacing: 20,
                    children: [
                      CustomTextField(
                        label: 'Name',
                        keyboardType: TextInputType.name,
                      ),
                      CustomTextField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextField(
                        label: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        isHidden: isHidden,
                        sufIcon: IconButton(
                          onPressed: () {
                            isHidden = !isHidden;
                            setState(() {});
                          },
                          icon: Icon(Icons.visibility_off),
                        ),
                      ),
                      CustomRow(data: 'Sign UP', onPressed: () {}),
                      CustomRow(data: 'Sign UP With Google', onPressed: () {}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have Account ?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 5),
                          CustomTextBtn(text: 'Login', onTap: () {}),
                        ],
                      ),
                    ],
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
