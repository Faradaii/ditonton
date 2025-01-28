import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc({
    required GetNowPlayingMovies getNowPlayingMovies,
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
  }) : super(MovieListEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      if (state is! MovieListLoaded) {
        emit(MovieListLoaded(movieNowPlayingState: RequestState.loading));
      } else {
        emit((state as MovieListLoaded)
            .copyWith(movieNowPlayingState: RequestState.loading));
      }
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit((state as MovieListLoaded).copyWith(
            movieNowPlayingState: RequestState.error,
            message: failure.message));
      }, (moviesData) {
        emit((state as MovieListLoaded).copyWith(
            movieNowPlayingState: RequestState.loaded,
            moviesNowPlaying: moviesData));
      });
    });
    on<FetchPopularMovies>((event, emit) async {
      if (state is! MovieListLoaded) {
        emit(MovieListLoaded(moviePopularState: RequestState.loading));
      } else {
        emit((state as MovieListLoaded)
            .copyWith(moviePopularState: RequestState.loading));
      }
      final result = await getPopularMovies.execute();
      result.fold((failure) {
        emit((state as MovieListLoaded).copyWith(
            moviePopularState: RequestState.error, message: failure.message));
      }, (moviesData) {
        emit((state as MovieListLoaded).copyWith(
            moviePopularState: RequestState.loaded, moviesPopular: moviesData));
      });
    });
    on<FetchTopRatedMovies>((event, emit) async {
      if (state is! MovieListLoaded) {
        emit(MovieListLoaded(movieTopRatedState: RequestState.loading));
      } else {
        emit((state as MovieListLoaded)
            .copyWith(movieTopRatedState: RequestState.loading));
      }
      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit((state as MovieListLoaded).copyWith(
            movieTopRatedState: RequestState.error, message: failure.message));
      }, (moviesData) {
        emit((state as MovieListLoaded).copyWith(
            movieTopRatedState: RequestState.loaded,
            moviesTopRated: moviesData));
      });
    });
  }
}
