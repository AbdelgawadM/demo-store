
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:our_store/core/widgets/custom_indicator.dart';

class CustomCashedImage extends StatelessWidget {
  const CustomCashedImage({
    super.key, required this.imageUrl,
  });
  final String imageUrl;
  final double width=double.infinity;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: 300,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) =>  SizedBox(
        height: 300,
        width: width,
        child: const CustomIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        height: 300,
        width: width,
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
