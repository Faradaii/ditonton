part of 'tv_search_bloc.dart';

sealed class TvSearchState extends Equatable {
  const TvSearchState();
}

final class TvSearchInitial extends TvSearchState {
  @override
  List<Object> get props => [];
}
