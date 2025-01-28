import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/get_now_playing_tv.dart';
import '../../../domain/usecases/tv/get_popular_tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  TvListBloc({
    required GetNowPlayingTv getNowPlayingTvList,
    required GetPopularTv getPopularTvList,
    required GetTopRatedTv getTopRatedTvList,
  }) : super(TvListEmpty()) {
    on<FetchNowPlayingTvList>((event, emit) async {
      if (state is! TvListLoaded) {
        emit(TvListLoaded(tvNowPlayingState: RequestState.loading));
      } else {
        emit((state as TvListLoaded)
            .copyWith(tvNowPlayingState: RequestState.loading));
      }
      final result = await getNowPlayingTvList.execute();
      result.fold((failure) {
        emit((state as TvListLoaded).copyWith(
            tvNowPlayingState: RequestState.error, message: failure.message));
      }, (tvListData) {
        emit((state as TvListLoaded).copyWith(
            tvNowPlayingState: RequestState.loaded,
            tvListNowPlaying: tvListData));
      });
    });
    on<FetchPopularTvList>((event, emit) async {
      if (state is! TvListLoaded) {
        emit(TvListLoaded(tvPopularState: RequestState.loading));
      } else {
        emit((state as TvListLoaded)
            .copyWith(tvPopularState: RequestState.loading));
      }
      final result = await getPopularTvList.execute();
      result.fold((failure) {
        emit((state as TvListLoaded).copyWith(
            tvPopularState: RequestState.error, message: failure.message));
      }, (tvListData) {
        emit((state as TvListLoaded).copyWith(
            tvPopularState: RequestState.loaded, tvListPopular: tvListData));
      });
    });
    on<FetchTopRatedTvList>((event, emit) async {
      if (state is! TvListLoaded) {
        emit(TvListLoaded(tvTopRatedState: RequestState.loading));
      } else {
        emit((state as TvListLoaded)
            .copyWith(tvTopRatedState: RequestState.loading));
      }
      final result = await getTopRatedTvList.execute();
      result.fold((failure) {
        emit((state as TvListLoaded).copyWith(
            tvTopRatedState: RequestState.error, message: failure.message));
      }, (tvListData) {
        emit((state as TvListLoaded).copyWith(
            tvTopRatedState: RequestState.loaded, tvListTopRated: tvListData));
      });
    });
  }
}
