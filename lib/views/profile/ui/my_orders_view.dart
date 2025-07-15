import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/custom_list.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomList(),
            ],
          ),
        ),
      ),
    );
  }
}