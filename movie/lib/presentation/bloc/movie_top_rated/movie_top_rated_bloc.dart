import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  MovieTopRatedBloc() : super(MovieTopRatedInitial()) {
    on<MovieTopRatedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
