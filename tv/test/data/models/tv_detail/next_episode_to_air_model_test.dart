import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/next_episode_to_air_model.dart';

void main() {
  group('NextEpisodeToAirModel JSON Serialization', () {
    const mockJson = {
      'id': 202,
      'name': 'Next Episode',
      'overview': 'This is the overview of the next episode.',
      'vote_average': 8.5,
      'vote_count': 100,
      'air_date': '2025-01-01',
      'episode_number': 2,
      'episode_type': 'regular',
      'production_code': 'EP202',
      'runtime': 45,
      'season_number': 1,
      'show_id': 101,
      'still_path': '/still_path.jpg',
    };

    const nextEpisodeModel = NextEpisodeToAirModel(
      id: 202,
      name: 'Next Episode',
      overview: 'This is the overview of the next episode.',
      voteAverage: 8.5,
      voteCount: 100,
      airDate: '2025-01-01',
      episodeNumber: 2,
      episodeType: 'regular',
      productionCode: 'EP202',
      runtime: 45,
      seasonNumber: 1,
      showId: 101,
      stillPath: '/still_path.jpg',
    );

    test('fromJson should return a valid model', () {
      // Act
      final result = NextEpisodeToAirModel.fromJson(mockJson);

      // Assert
      expect(result, nextEpisodeModel);
    });

    test('toJson should return a valid JSON map', () {
      // Act
      final result = nextEpisodeModel.toJson();

      // Assert
      expect(result, mockJson);
    });
  });
}
