import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/season/season_detail.dart';

import '../../../domain/usecases/tv/get_tv_detail_season.dart';

part 'tv_detail_season_event.dart';
part 'tv_detail_season_state.dart';

class TvDetailSeasonBloc
    extends Bloc<TvDetailSeasonEvent, TvDetailSeasonState> {
  TvDetailSeasonBloc({required GetTvDetailSeason getTvDetailSeason})
      : super(TvDetailSeasonEmpty()) {
    on<GetTvDetailSeasonEvent>((event, emit) async {
      emit(TvDetailSeasonLoading());

      final result = await getTvDetailSeason.execute(
          id: event.id, seasonNumber: event.seasonNumber);
      result.fold((failure) {
        emit(TvDetailSeasonError(failure.message));
      }, (tvList) {
        emit(TvDetailSeasonLoaded(tvList));
      });
    });
  }
}
