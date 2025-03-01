import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of popular tv series from the repository', () async {
    //arrange
    when(mockTvRepository.getPopularTvSeries())
        .thenAnswer((_) async => Right(tTv));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTv));
  });
}
