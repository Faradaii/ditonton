import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/guest_stars.dart';

class GuestStarsModel extends Equatable {
  GuestStarsModel({
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
    final _data = <String, dynamic>{};
    _data['character'] = character;
    _data['credit_id'] = creditId;
    _data['order'] = order;
    _data['adult'] = adult;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }

  GuestStars toEntity() => GuestStars(
      character: this.character,
      creditId: this.creditId,
      order: this.order,
      adult: this.adult,
      gender: this.gender,
      id: this.id,
      knownForDepartment: this.knownForDepartment,
      name: this.name,
      originalName: this.originalName,
      popularity: this.popularity,
      profilePath: this.profilePath);

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
