import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  MovieNowPlayingBloc() : super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
