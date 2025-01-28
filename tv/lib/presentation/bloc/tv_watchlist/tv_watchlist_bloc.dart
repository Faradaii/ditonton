import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/get_watchlist_tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  TvWatchlistBloc({required GetWatchlistTv getWatchlistTv})
      : super(TvWatchlistEmpty()) {
    on<GetTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());

      final result = await getWatchlistTv.execute();
      result.fold((failure) {
        emit(TvWatchlistError(failure.message));
      }, (tvList) {
        emit(TvWatchlistLoaded(tvList));
      });
    });
  }
}
