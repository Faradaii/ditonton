import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';

import '../../../domain/usecases/tv/get_tv_detail.dart';
import '../../../domain/usecases/tv/get_tv_recommendations.dart';
import '../../../domain/usecases/tv/get_watchlist_status.dart';
import '../../../domain/usecases/tv/remove_watchlist.dart';
import '../../../domain/usecases/tv/save_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required GetTvDetail getTvDetail,
    required GetTvRecommendation getTvRecommendation,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  }) : super(TvDetailEmpty()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold((failure) {
        emit(TvDetailError(message: failure.message));
      }, (tv) {
        emit(TvDetailLoaded(tv: tv));
        add(LoadWatchlistStatusEvent(event.id));
        add(GetTvRecommendationsEvent(event.id));
      });
    });
    on<GetTvRecommendationsEvent>((event, emit) async {
      final recommendationsResult = await getTvRecommendation.execute(event.id);
      if (state is TvDetailLoaded) {
        final currentState = state as TvDetailLoaded;
        emit(currentState.copyWith(recommendationState: RequestState.loading));
        recommendationsResult.fold((failure) {
          emit(currentState.copyWith(
              recommendationState: RequestState.error,
              message: failure.message));
        }, (tvList) {
          emit(currentState.copyWith(
              recommendationState: RequestState.loaded,
              recommendations: tvList));
        });
      }
    });
    on<LoadWatchlistStatusEvent>((event, emit) async {
      if (state is TvDetailLoaded) {
        final currentState = state as TvDetailLoaded;
        final result = await getWatchListStatus.execute(event.id);
        emit(currentState.copyWith(isAddedToWatchlist: result));
      }
    });
    on<AddWatchlistEvent>((event, emit) async {
      if (state is TvDetailLoaded) {
        final currentState = state as TvDetailLoaded;
        final result = await saveWatchlist.execute(event.tv);
        final reload = await getWatchListStatus.execute(event.tv.id);

        result.fold(
            (failure) =>
                emit(currentState.copyWith(watchlistMessage: failure.message)),
            (successMessage) => emit(
                  currentState.copyWith(
                      watchlistMessage: successMessage,
                      isAddedToWatchlist: reload),
                ));
      }
    });
    on<RemoveWatchlistEvent>((event, emit) async {
      if (state is TvDetailLoaded) {
        final currentState = state as TvDetailLoaded;
        final result = await removeWatchlist.execute(event.tv);
        final reload = await getWatchListStatus.execute(event.tv.id);

        result.fold(
            (failure) =>
                emit(currentState.copyWith(watchlistMessage: failure.message)),
            (successMessage) => emit(
                  currentState.copyWith(
                      watchlistMessage: successMessage,
                      isAddedToWatchlist: reload),
                ));
      }
    });
  }
}
