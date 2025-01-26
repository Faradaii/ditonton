import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieRecommendations getMovieRecommendations,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
          (failure) {
            emit(MovieDetailError(message: failure.message));
          },
          (movie) {
            emit(MovieDetailLoaded(movie: movie));
          }
      );
    });
    on<GetMovieRecommendationsEvent>((event, emit) async {
      final recommendationsResult = await getMovieRecommendations.execute(event.id);
        if (state is MovieDetailLoaded) {
          final currentState = state as MovieDetailLoaded;
          recommendationsResult.fold(
            (failure) {
              emit(currentState.copyWith(recommendationState: RequestState.error, message: failure.message));
            },
            (movies) {
              emit(currentState.copyWith(recommendationState: RequestState.loaded, recommendations: movies));
            }
          );
        }
    });
    on<LoadWatchlistStatusEvent>((event, emit) async {
      if (state is MovieDetailLoaded) {
        final currentState = state as MovieDetailLoaded;
        final result = await getWatchListStatus.execute(event.id);
        emit(currentState.copyWith(isAddedToWatchlist: result));
      }
    });
    on<AddWatchlistEvent>((event, emit) async {
      if(state is MovieDetailLoaded) {
        final currentState = state as MovieDetailLoaded;
        final result = await saveWatchlist.execute(event.movie);
        final reload = await getWatchListStatus.execute(event.movie.id);

        result.fold(
          (failure) => emit(currentState.copyWith(watchlistMessage: failure.message)),
        (successMessage) => emit(currentState.copyWith(watchlistMessage: successMessage, isAddedToWatchlist: reload),
        ));
      }
    });
    on<RemoveWatchlistEvent>((event, emit) async {
      if(state is MovieDetailLoaded) {
        final currentState = state as MovieDetailLoaded;
        final result = await removeWatchlist.execute(event.movie);
        final reload = await getWatchListStatus.execute(event.movie.id);

        result.fold(
                (failure) => emit(currentState.copyWith(watchlistMessage: failure.message)),
                (successMessage) => emit(currentState.copyWith(watchlistMessage: successMessage, isAddedToWatchlist: reload),
            ));
      }
    });
  }
}
