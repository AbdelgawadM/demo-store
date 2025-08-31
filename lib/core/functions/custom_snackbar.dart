import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: Colors.black87, // modern dark background
      behavior: SnackBarBehavior.floating, // makes it float above content
      margin: const EdgeInsets.all(36), // rounded edges
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 1),
    ),
  );
}
