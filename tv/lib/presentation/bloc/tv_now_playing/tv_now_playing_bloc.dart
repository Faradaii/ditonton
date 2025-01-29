import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/get_now_playing_tv.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  TvNowPlayingBloc({required GetNowPlayingTv getNowPlayingTv})
      : super(TvNowPlayingEmpty()) {
    on<GetTvNowPlayingEvent>((event, emit) async {
      emit(TvNowPlayingLoading());

      final result = await getNowPlayingTv.execute();
      result.fold((failure) {
        emit(TvNowPlayingError(failure.message));
      }, (tvList) {
        emit(TvNowPlayingLoaded(tvList));
      });
    });
  }
}
