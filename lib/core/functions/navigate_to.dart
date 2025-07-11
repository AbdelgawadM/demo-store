import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget view) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
