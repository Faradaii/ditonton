import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/last_episode_to_air_model.dart';

void main() {
  group('LastEpisodeToAirModel toJson Test', () {
    test('should return a JSON map with proper data', () {
      // Arrange
      const lastEpisodeToAirModel = LastEpisodeToAirModel(
        id: 1,
        name: 'Final Episode',
        overview: 'This is the last episode of the season.',
        voteAverage: 8.5,
        voteCount: 200,
        airDate: '2023-01-15',
        episodeNumber: 10,
        episodeType: 'Standard',
        productionCode: 'S1E10',
        runtime: 45,
        seasonNumber: 1,
        showId: 123,
        stillPath: '/still_path.jpg',
      );

      // Act
      final result = lastEpisodeToAirModel.toJson();

      // Assert
      expect(result, {
        'id': 1,
        'name': 'Final Episode',
        'overview': 'This is the last episode of the season.',
        'vote_average': 8.5,
        'vote_count': 200,
        'air_date': '2023-01-15',
        'episode_number': 10,
        'episode_type': 'Standard',
        'production_code': 'S1E10',
        'runtime': 45,
        'season_number': 1,
        'show_id': 123,
        'still_path': '/still_path.jpg',
      });
    });
  });
}
