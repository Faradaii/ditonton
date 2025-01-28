import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import 'custom_cached_image.dart';

class TvCardImageOnly extends StatelessWidget {
  final TvSeries tv;

  const TvCardImageOnly({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeDetailTv,
            arguments: tv.id,
          );
        },
        child: Semantics(
          label: tv.name,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: CustomCachedImage(
              imageUrl: '$baseImageUrl${tv.posterPath}',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
