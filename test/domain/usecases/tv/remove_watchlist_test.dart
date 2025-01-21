import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(mockTvRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
