import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailSeason usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetailSeason(mockTvRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;

  test('should get tv series season detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeriesSeasonDetail(
            id: tId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => Right(testSeasonDetail));
    // act
    final result = await usecase.execute(id: tId, seasonNumber: tSeasonNumber);
    // assert
    expect(result, Right(testSeasonDetail));
  });
}
