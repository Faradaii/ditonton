import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailSeasonEpisode usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetailSeasonEpisode(mockTvRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tEpisodeNumber = 1;

  test('should get tv series season episode detail from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvSeriesSeasonEpisodeDetail(
            id: tId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber))
        .thenAnswer((_) async => Right(testEpisodeDetail));
    // act
    final result = await usecase.execute(
        id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber);
    // assert
    expect(result, Right(testEpisodeDetail));
  });
}
