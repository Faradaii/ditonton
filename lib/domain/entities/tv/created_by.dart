
import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedBy(
      {required this.id,
        required this.creditId,
        required this.name,
        required this.originalName,
        required this.gender,
        required this.profilePath});

  @override
  List<Object?> get props => [
    id,
    creditId,
    name,
    originalName,
    gender,
    profilePath
  ];
}