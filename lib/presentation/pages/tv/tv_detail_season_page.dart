import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv/season/season_detail.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_season_episode_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_season_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';

class TvDetailSeasonPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-season';

  final int id;
  final int seasonNumber;

  const TvDetailSeasonPage(
      {super.key, required this.id, required this.seasonNumber});

  @override
  State<TvDetailSeasonPage> createState() => _TvDetailSeasonPageState();
}

class _TvDetailSeasonPageState extends State<TvDetailSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailSeasonNotifier>(context, listen: false)
          .fetchTvDetailSeason(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailSeasonNotifier>(
        builder: (context, provider, child) {
          if (provider.seasonState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.seasonState == RequestState.Loaded) {
            final season = provider.season;
            return SafeArea(
              child: DetailSeasonContent(
                season,
                widget.id,
                widget.seasonNumber,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailSeasonContent extends StatelessWidget {
  final Season seasonDetail;
  final int id;
  final int seasonNumber;

  DetailSeasonContent(this.seasonDetail, this.id, this.seasonNumber);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500/${seasonDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seasonDetail.name!,
                              style: kHeading5,
                            ),
                            Text(
                              "${seasonDetail.episodes?.length} episodes",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: seasonDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${seasonDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              seasonDetail.overview!,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            _buildEpisodes()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _buildEpisodes() {
    if (seasonDetail.episodes!.isEmpty) {
      return Center(
        child: Text("No Episode"),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 5,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final episodesItem = seasonDetail.episodes?[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, TvDetailSeasonEpisodePage.ROUTE_NAME,
                  arguments: {
                    'id': id,
                    'seasonNumber': seasonNumber,
                    'episodeNumber': episodesItem?.episodeNumber
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                color: kMikadoYellow,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    episodesItem?.episodeNumber.toString() ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kRichBlack, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episodesItem?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: kRichBlack,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _showDuration(episodesItem?.runtime ?? 0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: kRichBlack,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: seasonDetail.episodes!.length,
      ),
    );
  }
}
