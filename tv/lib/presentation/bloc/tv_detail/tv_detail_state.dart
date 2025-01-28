part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  final String message;

  const TvDetailState({this.message = ''});

  @override
  List<Object> get props => [];
}

final class TvDetailEmpty extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {
  const TvDetailError({super.message});

  @override
  List<Object> get props => [message];
}

final class TvDetailLoaded extends TvDetailState {
  final TvSeriesDetail tv;
  final List<TvSeries> recommendations;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TvDetailLoaded({
    required this.tv,
    this.isAddedToWatchlist = false,
    this.recommendations = const [],
    this.recommendationState = RequestState.empty,
    this.watchlistMessage = '',
    super.message,
  });

  TvDetailLoaded copyWith({
    TvSeriesDetail? tv,
    List<TvSeries>? recommendations,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return TvDetailLoaded(
      tv: tv ?? this.tv,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        tv,
        recommendations,
        recommendationState,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
