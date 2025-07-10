import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text('Welcome to our Market',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),)
        ],
      )),
    );
  }
}