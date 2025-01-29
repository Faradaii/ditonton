import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  TvTopRatedBloc({required GetTopRatedTv getTopRatedTv})
      : super(TvTopRatedEmpty()) {
    on<GetTvTopRatedEvent>((event, emit) async {
      emit(TvTopRatedLoading());

      final result = await getTopRatedTv.execute();
      result.fold((failure) {
        emit(TvTopRatedError(failure.message));
      }, (tvList) {
        emit(TvTopRatedLoaded(tvList));
      });
    });
  }
}
