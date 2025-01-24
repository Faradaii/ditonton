import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv/episode/episode.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_season_episode_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';

class TvDetailSeasonEpisodePage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-season-episode';

  final int id;
  final int seasonNumber;
  final int episodeNumber;

  const TvDetailSeasonEpisodePage(
      {super.key,
      required this.id,
      required this.seasonNumber,
      required this.episodeNumber});

  @override
  State<TvDetailSeasonEpisodePage> createState() =>
      _TvDetailSeasonEpisodePageState();
}

class _TvDetailSeasonEpisodePageState extends State<TvDetailSeasonEpisodePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailSeasonEpisodeNotifier>(context, listen: false)
          .fetchTvDetailSeasonEpisode(
              id: widget.id,
              seasonNumber: widget.seasonNumber,
              episodeNumber: widget.episodeNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailSeasonEpisodeNotifier>(
        builder: (context, provider, child) {
          if (provider.episodeState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.episodeState == RequestState.Loaded) {
            final episode = provider.episode;
            return SafeArea(
              child: DetailSeasonEpisodeContent(
                episode,
              ),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}

class DetailSeasonEpisodeContent extends StatelessWidget {
  final Episode episodeDetail;

  const DetailSeasonEpisodeContent(this.episodeDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episodeDetail.name!,
                          style: kHeading5,
                        ),
                        Text(
                          _showDuration(episodeDetail.runtime ?? 0),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: episodeDetail.voteAverage! / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 24,
                            ),
                            Text('${episodeDetail.voteAverage}')
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Overview',
                          style: kHeading6,
                        ),
                        Text(
                          episodeDetail.overview!,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Guest Stars',
                          style: kHeading6,
                        ),
                        _buildGuestStars(),
                        SizedBox(height: 16),
                        Text(
                          'Crews',
                          style: kHeading6,
                        ),
                        _buildCrew()
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

  Widget _buildGuestStars() {
    if (episodeDetail.guestStars!.isEmpty) {
      return Center(
        child: Text("No GuestStar"),
      );
    }
    return SizedBox(
        height: 150,
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: episodeDetail.guestStars?.length ?? 0,
            itemBuilder: (context, index) {
              final guestStar = episodeDetail.guestStars![index];
              return Container(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${guestStar.profilePath}',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        guestStar.character!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      Text(
                        guestStar.name!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _buildCrew() {
    if (episodeDetail.crew!.isEmpty) {
      return Center(
        child: Text("No Crew"),
      );
    }
    return SizedBox(
        height: 150,
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: episodeDetail.crew!.length,
            itemBuilder: (context, index) {
              final crew = episodeDetail.crew![index];
              return AspectRatio(
                aspectRatio: 9 / 16,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${crew.profilePath}',
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      crew.job!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      crew.name!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                  ],
                ),
              );
            }));
  }
}
