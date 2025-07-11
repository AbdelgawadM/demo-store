
import 'package:flutter/material.dart';
import 'package:our_store/views/auth/ui/widgets/custom_arrow_btn.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, this.onPressed, required this.data});
  final void Function()? onPressed;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(data, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        CustomArrowBtn(onPressed: onPressed),
      ],
    );
  }
}
