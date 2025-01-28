part of 'tv_search_bloc.dart';

abstract class TvSearchEvent {
  const TvSearchEvent();
}

class OnQueryChangedEvent extends TvSearchEvent {
  final String query;

  const OnQueryChangedEvent(this.query);
}
