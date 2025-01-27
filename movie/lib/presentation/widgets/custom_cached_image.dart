import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCachedImage extends StatelessWidget {
  final DefaultCacheManager? defaultCacheManager;
  final double? width;
  final Widget Function(BuildContext context, String url)? placeholder;
  final Widget Function(BuildContext context, String url, Object error)?
      errorWidget;
  final String imageUrl;
  final Key? errorKey;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.errorKey = const Key('error_load_image'),
    this.defaultCacheManager,
    this.width,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        cacheManager: defaultCacheManager,
        imageUrl: imageUrl,
        width: width,
        placeholder: placeholder,
        errorWidget: errorWidget);
  }
}
