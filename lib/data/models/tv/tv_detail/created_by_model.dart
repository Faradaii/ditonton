import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/created_by.dart';

class CreatedByModel extends Equatable {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  late final int id;
  late final String creditId;
  late final String name;
  late final String originalName;
  late final int gender;
  late final Null profilePath;

  CreatedByModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    originalName = json['original_name'];
    gender = json['gender'];
    profilePath = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['credit_id'] = creditId;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['gender'] = gender;
    _data['profile_path'] = profilePath;
    return _data;
  }

  CreatedBy toEntity() => CreatedBy(
      id: this.id,
      creditId: this.creditId,
      name: this.name,
      originalName: this.originalName,
      gender: this.gender,
      profilePath: this.profilePath);

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
