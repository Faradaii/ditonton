import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_image_only.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../bloc/tv_list/tv_list_bloc.dart';

class TvHomePage extends StatefulWidget {
  const TvHomePage({super.key});

  @override
  State<TvHomePage> createState() => _TvHomePageState();
}

class _TvHomePageState extends State<TvHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(FetchNowPlayingTvList());
    context.read<TvListBloc>().add(FetchPopularTvList());
    context.read<TvListBloc>().add(FetchTopRatedTvList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series'),
        actions: [
          IconButton(
            key: Key('search'),
            onPressed: () {
              Navigator.pushNamed(context, routeSearchTv);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                key: Key('now_playing'),
                title: 'Now Playing Tv Series',
                onTap: () => Navigator.pushNamed(context, routeNowPlayingTv),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state is TvListLoaded &&
                    state.tvPopularState == RequestState.loaded) {
                  if (state.tvListNowPlaying.isEmpty) {
                    return Center(
                      child: Text("No Tv Series found"),
                    );
                  }
                  return TvList(state.tvListNowPlaying);
                } else if (state is TvListLoaded &&
                    state.tvPopularState == RequestState.error) {
                  return Text(state.message);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                key: Key('popular'),
                title: 'Popular Tv Series',
                onTap: () => Navigator.pushNamed(context, routePopularTv),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state is TvListLoaded &&
                    state.tvPopularState == RequestState.loaded) {
                  if (state.tvListPopular.isEmpty) {
                    return Center(
                      child: Text("No Tv Series found"),
                    );
                  }
                  return TvList(state.tvListPopular);
                } else if (state is TvListLoaded &&
                    state.tvPopularState == RequestState.error) {
                  return Text(state.message);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                key: Key('top_rated'),
                title: 'Top Rated Tv Series',
                onTap: () => Navigator.pushNamed(context, routeTopRatedTv),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state is TvListLoaded &&
                    state.tvTopRatedState == RequestState.loaded) {
                  if (state.tvListTopRated.isEmpty) {
                    return Center(
                      child: Text("No Tv Series found"),
                    );
                  }
                  return TvList(state.tvListTopRated);
                } else if (state is TvListLoaded &&
                    state.tvTopRatedState == RequestState.error) {
                  return Text(state.message);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading(
      {required String title, required Function() onTap, Key? key}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: key,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> tv;

  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvItem = tv[index];
          return TvCardImageOnly(tv: tvItem);
        },
        itemCount: tv.length,
      ),
    );
  }
}
