import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlist(mockTvRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
