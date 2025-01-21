import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/crew.dart';

class CrewModel extends Equatable {
  CrewModel({
    required this.job,
    required this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final String? job;
  final String? department;
  final String? creditId;
  final bool? adult;
  final int? gender;
  final int id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        job: json['job'],
        department: json['department'],
        creditId: json['credit_id'],
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
    _data['job'] = job;
    _data['department'] = department;
    _data['credit_id'] = creditId;
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

  Crew toEntity() => Crew(
      job: this.job,
      department: this.department,
      creditId: this.creditId,
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
        job,
        department,
        creditId,
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
