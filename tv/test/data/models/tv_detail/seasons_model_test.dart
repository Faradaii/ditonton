import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/seasons_model.dart';

void main() {
  group('SeasonsModel toJson', () {
    const mockModel = SeasonsModel(
      airDate: '2023-01-01',
      episodeCount: 10,
      id: 1,
      name: 'Season 1',
      overview: 'This is the overview of season 1.',
      posterPath: '/posterPath.jpg',
      seasonNumber: 1,
      voteAverage: 8.5,
    );

    const expectedJson = {
      'air_date': '2023-01-01',
      'episode_count': 10,
      'id': 1,
      'name': 'Season 1',
      'overview': 'This is the overview of season 1.',
      'poster_path': '/posterPath.jpg',
      'season_number': 1,
      'vote_average': 8.5,
    };

    test('toJson should return a valid JSON map', () {
      // Act
      final result = mockModel.toJson();

      // Assert
      expect(result, expectedJson);
    });
  });
}
