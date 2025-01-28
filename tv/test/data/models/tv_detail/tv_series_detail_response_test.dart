import 'package:test/test.dart';
import 'package:tv/data/models/tv/tv_detail/tv_detail_model.dart';

void main() {
  group('TvSeriesDetailResponse', () {
    test('should correctly convert to JSON', () {
      final tvSeriesDetail = TvSeriesDetailResponse(
        adult: true,
        backdropPath: '/path/to/backdrop',
        createdBy: [],
        episodeRunTime: [60],
        firstAirDate: '2020-01-01',
        genres: [],
        homepage: 'https://example.com',
        id: 123,
        inProduction: false,
        languages: ['en'],
        lastAirDate: '2022-01-01',
        lastEpisodeToAir: null,
        // Adjust based on actual test data
        name: 'Test TV Series',
        nextEpisodeToAir: null,
        // Adjust based on actual test data
        networks: [],
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originCountry: ['US'],
        originalLanguage: 'English',
        originalName: 'Original Test Name',
        overview: 'A test series',
        popularity: 7.5,
        posterPath: '/path/to/poster',
        productionCompanies: [],
        productionCountries: [],
        seasons: [],
        spokenLanguages: [],
        status: 'Ended',
        tagline: 'A test tagline',
        type: 'Scripted',
        voteAverage: 8.5,
        voteCount: 100,
      );

      final result = tvSeriesDetail.toJson();

      // Check if all required fields are present and match the expected values
      expect(result['adult'], true);
      expect(result['backdrop_path'], '/path/to/backdrop');
      expect(result['created_by'], isEmpty);
      expect(result['episode_run_time'], [60]);
      expect(result['first_air_date'], '2020-01-01');
      expect(result['genres'], isEmpty);
      expect(result['homepage'], 'https://example.com');
      expect(result['id'], 123);
      expect(result['in_production'], false);
      expect(result['languages'], ['en']);
      expect(result['last_air_date'], '2022-01-01');
      expect(result['name'], 'Test TV Series');
      expect(result['next_episode_to_air'], isNull);
      expect(result['networks'], isEmpty);
      expect(result['number_of_episodes'], 10);
      expect(result['number_of_seasons'], 1);
      expect(result['origin_country'], ['US']);
      expect(result['original_language'], 'English');
      expect(result['original_name'], 'Original Test Name');
      expect(result['overview'], 'A test series');
      expect(result['popularity'], 7.5);
      expect(result['poster_path'], '/path/to/poster');
      expect(result['production_companies'], isEmpty);
      expect(result['production_countries'], isEmpty);
      expect(result['seasons'], isEmpty);
      expect(result['spoken_languages'], isEmpty);
      expect(result['status'], 'Ended');
      expect(result['tagline'], 'A test tagline');
      expect(result['type'], 'Scripted');
      expect(result['vote_average'], 8.5);
      expect(result['vote_count'], 100);
    });
  });
}
