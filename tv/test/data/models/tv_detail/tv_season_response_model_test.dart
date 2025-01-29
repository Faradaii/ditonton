import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/crew_model.dart';
import 'package:tv/data/models/tv/tv_detail/episodes_model.dart';
import 'package:tv/data/models/tv/tv_detail/guest_stars.dart';
import 'package:tv/data/models/tv/tv_detail/season_response.dart';

import '../../../json_reader.dart';

void main() {
  final tSeasonResponse = SeasonResponse(
      idAlternative: "1",
      airDate: "1994-11-19",
      episodes: [
        EpisodesModel(
            airDate: "1994-11-19",
            episodeNumber: 1,
            episodeType: "standard",
            id: 1,
            name: "Name",
            overview: "overview",
            productionCode: "",
            runtime: 1,
            seasonNumber: 1,
            showId: 1,
            stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
            voteAverage: 1.0,
            voteCount: 1,
            crew: [
              CrewModel(
                  department: "department",
                  job: "job",
                  creditId: "52540b6e19c29579402f9a93",
                  adult: false,
                  gender: 2,
                  id: 1,
                  knownForDepartment: "Writing",
                  name: "Jname",
                  originalName: "original_name",
                  popularity: 3.21,
                  profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
            ],
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
            ]),
      ],
      name: "Season 1",
      overview: "",
      id: 1,
      posterPath: "/f1Dy2F8of9uZiSz6Z3kTlzpWz6L.jpg",
      seasonNumber: 1,
      voteAverage: 1.0);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_season_detail.json'));
      // act
      final result = SeasonResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeasonResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonResponse.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "1",
        "air_date": "1994-11-19",
        "episodes": [
          {
            "air_date": "1994-11-19",
            "episode_number": 1,
            "episode_type": "standard",
            "id": 1,
            "name": "Name",
            "overview": "overview",
            "production_code": "",
            "runtime": 1,
            "season_number": 1,
            "show_id": 1,
            "still_path": "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
            "vote_average": 1,
            "vote_count": 1,
            "crew": [
              {
                "department": "department",
                "job": "job",
                "credit_id": "52540b6e19c29579402f9a93",
                "adult": false,
                "gender": 2,
                "id": 1,
                "known_for_department": "Writing",
                "name": "Jname",
                "original_name": "original_name",
                "popularity": 3.21,
                "profile_path": "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"
              }
            ],
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
            ]
          }
        ],
        "name": "Season 1",
        "overview": "",
        "id": 1,
        "poster_path": "/f1Dy2F8of9uZiSz6Z3kTlzpWz6L.jpg",
        "season_number": 1,
        "vote_average": 1.0
      };
      expect(result, expectedJsonMap);
    });
  });
}
