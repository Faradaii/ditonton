import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv/seasons.dart';

class TvSeasonCard extends StatelessWidget {
  final int tvDetailId;
  final Seasons? season;

  const TvSeasonCard({super.key, required this.tvDetailId, this.season});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeDetailSeasonTv,
                  arguments: {
                    'id': tvDetailId,
                    'seasonNumber': season?.seasonNumber
                  },
                );
              },
              child: Semantics(
                label: season?.posterPath,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl/${season?.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Text(
            season?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${season?.episodeCount} episodes",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
