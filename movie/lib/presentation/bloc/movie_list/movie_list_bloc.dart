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
      emit(MovieListLoaded(movieNowPlayingState: RequestState.loading));
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieListLoaded(movieNowPlayingState: RequestState.error, message: failure.message));
      }, (moviesData) {
        emit(MovieListLoaded(movieNowPlayingState: RequestState.loaded, moviesNowPlaying: moviesData));
      });
    });
    on<FetchPopularMovies>((event, emit) async {
      emit(MovieListLoaded(moviePopularState: RequestState.loading));
      final result = await getPopularMovies.execute();
      result.fold((failure) {
        emit(MovieListLoaded(moviePopularState: RequestState.error, message: failure.message));
      }, (moviesData) {
        emit(MovieListLoaded(moviePopularState: RequestState.loaded, moviesPopular: moviesData));
      });
    });
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MovieListLoaded(movieTopRatedState: RequestState.loading));
      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MovieListLoaded(movieTopRatedState: RequestState.error, message: failure.message));
      }, (moviesData) {
        emit(MovieListLoaded(movieTopRatedState: RequestState.loaded, moviesTopRated: moviesData));
      });
    });
  }
}
