part of 'tv_detail_bloc.dart';

sealed class TvDetailState extends Equatable {
  const TvDetailState();
}

final class TvDetailInitial extends TvDetailState {
  @override
  List<Object> get props => [];
}
