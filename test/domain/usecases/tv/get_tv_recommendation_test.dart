import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendation usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendation(mockTvRepository);
  });

  final tTv = <TvSeries>[];
  final int id = 1;

  test('should get list of recommendation tv series from the repository',
      () async {
    //arrange
    when(mockTvRepository.getTvSeriesRecommendations(id))
        .thenAnswer((_) async => Right(tTv));
    //act
    final result = await usecase.execute(id);
    //assert
    expect(result, Right(tTv));
  });
}
