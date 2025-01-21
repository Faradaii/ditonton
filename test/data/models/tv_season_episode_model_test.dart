import 'package:ditonton/data/models/tv/tv_detail/crew_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/episode_response.dart';
import 'package:ditonton/data/models/tv/tv_detail/episodes_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/guest_stars.dart';
import 'package:ditonton/data/models/tv/tv_detail/season_response.dart';
import 'package:ditonton/domain/entities/tv/crew.dart';
import 'package:ditonton/domain/entities/tv/episode/episode.dart';
import 'package:ditonton/domain/entities/tv/episodes.dart';
import 'package:ditonton/domain/entities/tv/guest_stars.dart';
import 'package:ditonton/domain/entities/tv/season/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final tEpisode = Episode(
      airDate: "1994-11-19",
      crew: [
        Crew(
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

  test('should be a subclass of Tv series season episode entity', () async {
    final result = tEpisodeResponse.toEntity();
    expect(result, tEpisode);
  });
}
