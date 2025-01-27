import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  MovieTopRatedBloc({required GetTopRatedMovies getTopRatedMovies})
      : super(MovieTopRatedEmpty()) {
    on<GetMovieTopRatedEvent>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MovieTopRatedError(failure.message));
      }, (movies) {
        emit(MovieTopRatedLoaded(movies));
      });
    });
  }
}
