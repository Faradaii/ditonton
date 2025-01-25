part of 'tv_list_bloc.dart';

sealed class TvListState extends Equatable {
  const TvListState();
}

final class TvListInitial extends TvListState {
  @override
  List<Object> get props => [];
}
