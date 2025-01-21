import 'package:ditonton/data/models/tv/tv_detail/crew_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/episodes_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/guest_stars.dart';
import 'package:ditonton/data/models/tv/tv_detail/season_response.dart';
import 'package:ditonton/domain/entities/tv/crew.dart';
import 'package:ditonton/domain/entities/tv/episodes.dart';
import 'package:ditonton/domain/entities/tv/guest_stars.dart';
import 'package:ditonton/domain/entities/tv/season/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonResponse = SeasonResponse(
      id_alternative: "1",
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

  final tSeason = Season(
      id_alternative: "1",
      airDate: "1994-11-19",
      episodes: [
        Episodes(
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
              Crew(
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
              GuestStars(
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

  test('should be a subclass of Tv series season entity', () async {
    final result = tSeasonResponse.toEntity();
    expect(result, tSeason);
  });
}
