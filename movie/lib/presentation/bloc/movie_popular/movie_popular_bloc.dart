import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  MoviePopularBloc({required GetPopularMovies getPopularMovies})
      : super(MoviePopularEmpty()) {
    on<GetMoviePopularEvent>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await getPopularMovies.execute();
      result.fold((failure) {
        emit(MoviePopularError(failure.message));
      }, (movies) {
        emit(MoviePopularLoaded(movies));
      });
    });
  }
}
