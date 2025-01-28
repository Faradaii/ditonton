part of 'tv_list_bloc.dart';

abstract class TvListEvent {
  const TvListEvent();
}

class FetchNowPlayingTvList extends TvListEvent {}

class FetchPopularTvList extends TvListEvent {}

class FetchTopRatedTvList extends TvListEvent {}
