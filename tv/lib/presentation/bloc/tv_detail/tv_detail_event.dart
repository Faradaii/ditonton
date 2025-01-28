part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  const GetTvDetailEvent(this.id);
}

class GetTvRecommendationsEvent extends TvDetailEvent {
  final int id;

  const GetTvRecommendationsEvent(this.id);
}

class LoadWatchlistStatusEvent extends TvDetailEvent {
  final int id;

  const LoadWatchlistStatusEvent(this.id);
}

class AddWatchlistEvent extends TvDetailEvent {
  final TvSeriesDetail tv;

  const AddWatchlistEvent(this.tv);
}

class RemoveWatchlistEvent extends TvDetailEvent {
  final TvSeriesDetail tv;

  const RemoveWatchlistEvent(this.tv);
}
