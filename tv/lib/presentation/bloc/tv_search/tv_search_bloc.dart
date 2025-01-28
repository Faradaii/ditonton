import 'package:bloc/bloc.dart';
import 'package:core/helper/bloc_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/search_tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  TvSearchBloc({required SearchTv searchTv}) : super(TvSearchEmpty()) {
    on<OnQueryChangedEvent>((event, emit) async {
      emit(TvSearchLoading());

      final String query = event.query;
      final result = await searchTv.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (tvList) {
          emit(TvSearchLoaded(tvList));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
