
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';

class CustomCashedImage extends StatelessWidget {
  const CustomCashedImage({
    super.key, required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          imageUrl,
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
      placeholder: (context, url) => const SizedBox(
        height: 300,
        width: double.infinity,
        child: CustomIndicator(),
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
