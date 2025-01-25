import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/spoken_languages.dart';

class SpokenLanguagesModel extends Equatable {
  const SpokenLanguagesModel({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });

  final String? englishName;
  final String? iso_639_1;
  final String? name;

  factory SpokenLanguagesModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguagesModel(
        englishName: json['english_name'],
        iso_639_1: json['iso_639_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso_639_1;
    data['name'] = name;
    return data;
  }

  SpokenLanguages toEntity() => SpokenLanguages(
        englishName: englishName,
        iso6391: iso_639_1,
        name: name,
      );

  @override
  List<Object?> get props => [englishName, iso_639_1, name];
}
