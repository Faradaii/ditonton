import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/tv/season/season_detail.dart';
import '../../bloc/tv_detail_season/tv_detail_season_bloc.dart';

class TvDetailSeasonPage extends StatefulWidget {
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
    context
        .read<TvDetailSeasonBloc>()
        .add(GetTvDetailSeasonEvent(widget.id, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailSeasonBloc, TvDetailSeasonState>(
          builder: (context, state) {
        if (state is TvDetailSeasonLoaded) {
          final season = state.season;
          return SafeArea(
            child: DetailSeasonContent(
              season,
              widget.id,
              widget.seasonNumber,
            ),
          );
        } else if (state is TvDetailSeasonError) {
          return Center(
            key: Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class DetailSeasonContent extends StatelessWidget {
  final Season seasonDetail;
  final int id;
  final int seasonNumber;

  const DetailSeasonContent(this.seasonDetail, this.id, this.seasonNumber,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl/${seasonDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
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
              Navigator.pushNamed(context, routeDetailSeasonEpisodeTv,
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
