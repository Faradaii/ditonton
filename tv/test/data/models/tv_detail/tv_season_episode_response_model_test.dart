import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/crew_model.dart';
import 'package:tv/data/models/tv/tv_detail/episode_response.dart';
import 'package:tv/data/models/tv/tv_detail/guest_stars.dart';

import '../../../json_reader.dart';

void main() {
  final tEpisodeResponse = EpisodeResponse(
      airDate: "1994-11-19",
      crew: [
        CrewModel(
            department: "department",
            job: "job",
            creditId: "credit_id",
            adult: false,
            gender: 2,
            id: 1,
            knownForDepartment: "known_for_department",
            name: "name",
            originalName: "original_name",
            popularity: 2.293,
            profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
      ],
      episodeNumber: 1,
      guestStars: [
        GuestStarsModel(
            character: "character",
            creditId: "credit_id",
            order: 1,
            adult: false,
            gender: 2,
            id: 1,
            knownForDepartment: "known_for_department",
            name: "name",
            originalName: "original_name",
            popularity: 0.938,
            profilePath: "profile_path"),
      ],
      name: "name",
      overview: "overview",
      id: 1,
      productionCode: "",
      runtime: 1,
      seasonNumber: 1,
      stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
      voteAverage: 1.0,
      voteCount: 1);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_episode_detail.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponse.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "1994-11-19",
        "crew": [
          {
            "department": "department",
            "job": "job",
            "credit_id": "credit_id",
            "adult": false,
            "gender": 2,
            "id": 1,
            "known_for_department": "known_for_department",
            "name": "name",
            "original_name": "original_name",
            "popularity": 2.293,
            "profile_path": "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"
          }
        ],
        "episode_number": 1,
        "guest_stars": [
          {
            "character": "character",
            "credit_id": "credit_id",
            "order": 1,
            "adult": false,
            "gender": 2,
            "id": 1,
            "known_for_department": "known_for_department",
            "name": "name",
            "original_name": "original_name",
            "popularity": 0.938,
            "profile_path": "profile_path"
          }
        ],
        "name": "name",
        "overview": "overview",
        "id": 1,
        "production_code": "",
        "runtime": 1,
        "season_number": 1,
        "still_path": "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
        "vote_average": 1.0,
        "vote_count": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
