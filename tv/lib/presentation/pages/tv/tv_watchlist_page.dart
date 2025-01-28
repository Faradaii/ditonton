import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv_watchlist/tv_watchlist_bloc.dart';
import '../../widgets/tv_card_list.dart';

class TvWatchlistPage extends StatefulWidget {
  const TvWatchlistPage({super.key});

  @override
  State<TvWatchlistPage> createState() => _TvWatchlistPageState();
}

class _TvWatchlistPageState extends State<TvWatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvWatchlistBloc>().add(GetTvWatchlistEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvWatchlistBloc>().add(GetTvWatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchlistLoaded) {
              if (state.tvList.isEmpty) {
                return _buildEmpty();
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvList[index];
                  return TvCard(tv);
                },
                itemCount: state.tvList.length,
              );
            } else if (state is TvWatchlistError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text('No tv series found, try add some!.'),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
