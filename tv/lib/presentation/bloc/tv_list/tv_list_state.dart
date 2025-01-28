part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  final String message;

  const TvListState({this.message = ''});
  @override
  List<Object> get props => [message];
}

final class TvListEmpty extends TvListState {}

final class TvListLoaded extends TvListState {
  final List<TvSeries> tvListNowPlaying;
  final RequestState tvNowPlayingState;
  final List<TvSeries> tvListPopular;
  final RequestState tvPopularState;
  final List<TvSeries> tvListTopRated;
  final RequestState tvTopRatedState;

  const TvListLoaded({
    this.tvListNowPlaying = const [],
    this.tvNowPlayingState = RequestState.empty,
    this.tvListPopular = const [],
    this.tvPopularState = RequestState.empty,
    this.tvListTopRated = const [],
    this.tvTopRatedState = RequestState.empty,
    super.message,
  });

  TvListLoaded copyWith({
    List<TvSeries>? tvListNowPlaying,
    RequestState? tvNowPlayingState,
    List<TvSeries>? tvListPopular,
    RequestState? tvPopularState,
    List<TvSeries>? tvListTopRated,
    RequestState? tvTopRatedState,
    String? message,
  }) {
    return TvListLoaded(
      tvListNowPlaying: tvListNowPlaying ?? this.tvListNowPlaying,
      tvNowPlayingState: tvNowPlayingState ?? this.tvNowPlayingState,
      tvListPopular: tvListPopular ?? this.tvListPopular,
      tvPopularState: tvPopularState ?? this.tvPopularState,
      tvListTopRated: tvListTopRated ?? this.tvListTopRated,
      tvTopRatedState: tvTopRatedState ?? this.tvTopRatedState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        tvListNowPlaying,
        tvNowPlayingState,
        tvListPopular,
        tvPopularState,
        tvListTopRated,
        tvTopRatedState,
        message,
      ];
}
