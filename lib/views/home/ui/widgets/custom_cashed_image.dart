
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:our_store/core/app_colors.dart';

class CustomCashedImage extends StatelessWidget {
  const CustomCashedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          'https://images.pexels.com/photos/8268989/pexels-photo-8268989.jpeg?cs=srgb&dl=pexels-perfect-lens-8268989.jpg&fm=jpg',
      imageBuilder: (context, imageProvider) => Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: 300,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(
            Icons.error,
            size: 60,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
