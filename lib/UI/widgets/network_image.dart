import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage(
      {super.key, required this.url, this.height, this.width, this.fit});

  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (_, __, ___) {
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
      },
      errorWidget: (_, __, ___) {
        return const Icon(Icons.person);
      },
      height: height,
      width: width,
      fit: fit,
    );
  }
}
