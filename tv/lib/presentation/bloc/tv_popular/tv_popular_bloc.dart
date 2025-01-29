import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/get_popular_tv.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  TvPopularBloc({required GetPopularTv getPopularTv})
      : super(TvPopularEmpty()) {
    on<GetTvPopularEvent>((event, emit) async {
      emit(TvPopularLoading());

      final result = await getPopularTv.execute();
      result.fold((failure) {
        emit(TvPopularError(failure.message));
      }, (tvList) {
        emit(TvPopularLoaded(tvList));
      });
    });
  }
}
