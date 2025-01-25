import 'package:core/common/state_enum.dart';
import 'package:movie/presentation/provider/now_playing_movie_notifier.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviePage extends StatefulWidget {
  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingMovieNotifier>(context, listen: false)
            .fetchNowPlayingMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingMovieNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
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
