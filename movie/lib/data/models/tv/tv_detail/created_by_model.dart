import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/created_by.dart';

class CreatedByModel extends Equatable {
  const CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  final int id;
  final String? creditId;
  final String? name;
  final String? originalName;
  final int? gender;
  final String? profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json['id'],
        creditId: json['credit_id'],
        name: json['name'],
        originalName: json['original_name'],
        gender: json['gender'],
        profilePath: json['profile_path'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['credit_id'] = creditId;
    data['name'] = name;
    data['original_name'] = originalName;
    data['gender'] = gender;
    data['profile_path'] = profilePath;
    return data;
  }

  CreatedBy toEntity() => CreatedBy(
      id: id,
      creditId: creditId,
      name: name,
      originalName: originalName,
      gender: gender,
      profilePath: profilePath);

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        originalName,
        gender,
        profilePath,
      ];
}
