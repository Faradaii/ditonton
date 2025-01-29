import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  MovieNowPlayingBloc({required GetNowPlayingMovies getNowPlayingMovies})
      : super(MovieNowPlayingEmpty()) {
    on<GetMovieNowPlayingEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieNowPlayingError(failure.message));
      }, (movies) {
        emit(MovieNowPlayingLoaded(movies));
      });
    });
  }
}
