import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  MovieWatchlistBloc({required GetWatchlistMovies getWatchlistMovies})
      : super(MovieWatchlistEmpty()) {
    on<GetMovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await getWatchlistMovies.execute();
      result.fold((failure) {
        emit(MovieWatchlistError(failure.message));
      }, (movies) {
        emit(MovieWatchlistLoaded(movies));
      });
    });
  }
}
