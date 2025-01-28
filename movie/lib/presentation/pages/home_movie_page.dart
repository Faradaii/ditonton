import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

import '../widgets/movie_card_image_only.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(FetchNowPlayingMovies());
    context.read<MovieListBloc>().add(FetchPopularMovies());
    context.read<MovieListBloc>().add(FetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipOval(
                child: Image.asset(
                  'assets/circle-g.png',
                  width: 100,
                  height: 100,
                ),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, routeHomeTv);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, routeWatchlistMovie);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv'),
              onTap: () {
                Navigator.pushNamed(context, routeWatchlistTv);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, routeAbout);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            key: Key('search'),
            onPressed: () {
              Navigator.pushNamed(context, routeSearchMovie);
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
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(context, routeNowPlayingMovie),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MovieListLoaded &&
                    state.movieNowPlayingState == RequestState.loaded) {
                  if (state.moviesNowPlaying.isEmpty) {
                    return Center(
                      child: Text("No movies found"),
                    );
                  }
                  return MovieList(state.moviesNowPlaying);
                } else if (state is MovieListLoaded &&
                    state.movieNowPlayingState == RequestState.error) {
                  return Text(state.message);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                key: Key('popular'),
                title: 'Popular Movies',
                onTap: () => Navigator.pushNamed(context, routePopularMovie),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MovieListLoaded &&
                    state.moviePopularState == RequestState.loaded) {
                  if (state.moviesPopular.isEmpty) {
                    return Center(
                      child: Text("No movies found"),
                    );
                  }
                  return MovieList(state.moviesPopular);
                } else if (state is MovieListLoaded &&
                    state.moviePopularState == RequestState.error) {
                  return Text(state.message);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              _buildSubHeading(
                key: Key('top_rated'),
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(context, routeTopRatedMovie),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MovieListLoaded &&
                    state.movieTopRatedState == RequestState.loaded) {
                  if (state.moviesTopRated.isEmpty) {
                    return Center(
                      child: Text("No movies found"),
                    );
                  }
                  return MovieList(state.moviesTopRated);
                } else if (state is MovieListLoaded &&
                    state.movieTopRatedState == RequestState.error) {
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCardImageOnly(movie: movie);
        },
        itemCount: movies.length,
      ),
    );
  }
}
