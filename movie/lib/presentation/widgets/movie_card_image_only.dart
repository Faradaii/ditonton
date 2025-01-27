import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'custom_cached_image.dart';

class MovieCardImageOnly extends StatelessWidget {
  final Movie movie;

  const MovieCardImageOnly({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeDetailMovie,
            arguments: movie.id,
          );
        },
        child: Semantics(
          label: movie.title,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: CustomCachedImage(
              imageUrl: '$baseImageUrl${movie.posterPath}',
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
