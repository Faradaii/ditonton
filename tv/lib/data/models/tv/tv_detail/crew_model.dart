import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/crew.dart';

class CrewModel extends Equatable {
  const CrewModel({
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
    final data = <String, dynamic>{};
    data['job'] = job;
    data['department'] = department;
    data['credit_id'] = creditId;
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

  Crew toEntity() => Crew(
      job: job,
      department: department,
      creditId: creditId,
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
