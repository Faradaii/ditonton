import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of top rated tv series from the repository', () async {
    //arrange
    when(mockTvRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTv));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTv));
  });
}
