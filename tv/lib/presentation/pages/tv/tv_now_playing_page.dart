import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tv/tv_now_playing_notifier.dart';
import '../../widgets/tv_card_list.dart';

class TvNowPlayingPage extends StatefulWidget {
  const TvNowPlayingPage({super.key});

  @override
  State<TvNowPlayingPage> createState() => _TvNowPlayingPageState();
}

class _TvNowPlayingPageState extends State<TvNowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvNowPlayingNotifier>(context, listen: false)
            .fetchNowPlayingTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvNowPlayingNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
                itemCount: data.tv.length,
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
}
