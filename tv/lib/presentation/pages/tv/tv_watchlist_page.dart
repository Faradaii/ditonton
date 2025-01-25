import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tv/tv_watchlist_notifier.dart';
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
    Future.microtask(() =>
        Provider.of<TvWatchlistNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<TvWatchlistNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvWatchlistNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              if (data.watchlistTv.isEmpty) {
                return _buildEmpty();
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.watchlistTv[index];
                  return TvCard(tv);
                },
                itemCount: data.watchlistTv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
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
