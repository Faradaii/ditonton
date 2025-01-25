import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  TvListBloc() : super(TvListInitial()) {
    on<TvListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
