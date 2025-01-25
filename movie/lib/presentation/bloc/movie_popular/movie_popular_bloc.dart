import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  MoviePopularBloc() : super(MoviePopularInitial()) {
    on<MoviePopularEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
