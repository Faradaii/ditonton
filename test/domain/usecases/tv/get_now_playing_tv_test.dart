import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingTv(mockTvRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of now playing tv series from the repository',
      () async {
    //arrange
    when(
        mockTvRepository.getNowPlayingTvSeries().then((_) async => Right(tTv)));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTv));
  });
}
