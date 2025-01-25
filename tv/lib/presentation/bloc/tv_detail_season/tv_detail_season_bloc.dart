import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_season_event.dart';
part 'tv_detail_season_state.dart';

class TvDetailSeasonBloc
    extends Bloc<TvDetailSeasonEvent, TvDetailSeasonState> {
  TvDetailSeasonBloc() : super(TvDetailSeasonInitial()) {
    on<TvDetailSeasonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
