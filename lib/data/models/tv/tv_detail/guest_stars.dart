import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/guest_stars.dart';

class GuestStarsModel extends Equatable {
  const GuestStarsModel({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final String? character;
  final String? creditId;
  final int? order;
  final bool? adult;
  final int? gender;
  final int id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  factory GuestStarsModel.fromJson(Map<String, dynamic> json) =>
      GuestStarsModel(
        character: json['character'],
        creditId: json['credit_id'],
        order: json['order'],
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        originalName: json['original_name'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    return data;
  }

  GuestStars toEntity() => GuestStars(
      character: character,
      creditId: creditId,
      order: order,
      adult: adult,
      gender: gender,
      id: id,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath);

  @override
  List<Object?> get props => [
        character,
        creditId,
        order,
        adult,
        gender,
        id,
        knownForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
      ];
}
