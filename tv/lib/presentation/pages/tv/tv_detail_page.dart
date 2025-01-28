import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/widgets/tv_season_card.dart';

import '../../../domain/entities/tv/genres.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../bloc/tv_detail/tv_detail_bloc.dart';
import '../../widgets/tv_card_image_only.dart';

class TvDetailPage extends StatefulWidget {
  final int id;

  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(GetTvDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(builder: (context, state) {
        if (state is TvDetailLoaded) {
          final tv = state.tv;
          return SafeArea(
            child: DetailContent(
              tv,
            ),
          );
        } else if (state is TvDetailError) {
          return Center(child: Text(state.message));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvDetail;

  const DetailContent(this.tvDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${tvDetail.posterPath}',
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
                              tvDetail.name!,
                              style: kHeading5,
                            ),
                            BlocConsumer<TvDetailBloc, TvDetailState>(
                                listener: (context, state) {
                              if (state is TvDetailLoaded &&
                                  state.watchlistMessage.isNotEmpty) {
                                if (state.watchlistMessage ==
                                        TvDetailBloc
                                            .watchlistAddSuccessMessage ||
                                    state.watchlistMessage ==
                                        TvDetailBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(state.watchlistMessage),
                                          duration:
                                              const Duration(seconds: 1)));
                                }
                              }
                            }, builder: (context, state) {
                              return FilledButton(
                                key: Key('watchlist_button'),
                                onPressed: () async {
                                  if (state is TvDetailLoaded &&
                                      !state.isAddedToWatchlist) {
                                    context
                                        .read<TvDetailBloc>()
                                        .add(AddWatchlistEvent(tvDetail));
                                  } else if (state is TvDetailLoaded &&
                                      state.isAddedToWatchlist) {
                                    context
                                        .read<TvDetailBloc>()
                                        .add(RemoveWatchlistEvent(tvDetail));
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state is TvDetailLoaded &&
                                            state.isAddedToWatchlist
                                        ? Icon(Icons.check)
                                        : Icon(Icons.add),
                                    Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              tvDetail.genres != null
                                  ? _showGenres(tvDetail.genres!)
                                  : "No genres",
                            ),
                            Text(
                              "${tvDetail.numberOfSeasons} season(s) ${tvDetail.numberOfEpisodes} episodes",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview!,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'seasons',
                              style: kHeading6,
                            ),
                            _buildSeasons(),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvDetailBloc, TvDetailState>(
                                builder: (context, state) {
                              if (state is TvDetailLoaded &&
                                  state.recommendationState ==
                                      RequestState.error) {
                                return Center(child: Text(state.message));
                              } else if (state is TvDetailLoaded &&
                                  state.recommendationState ==
                                      RequestState.loaded) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.recommendations[index];
                                      return TvCardImageOnly(tv: tv);
                                    },
                                    itemCount: state.recommendations.length,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Semantics(
                                      label: 'recommendation_loading',
                                      child: CircularProgressIndicator()),
                                );
                              }
                            })
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

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += (genre.name != null ? '${genre.name!}, ' : '');
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget _buildSeasons() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final seasonItem = tvDetail.seasons?[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: TvSeasonCard(tvDetailId: tvDetail.id, season: seasonItem),
          );
        },
        itemCount: tvDetail.seasons?.length,
      ),
    );
  }
}
