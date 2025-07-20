import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget view) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
void navigateToWithoutBack(BuildContext context, Widget view) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => view));
}
