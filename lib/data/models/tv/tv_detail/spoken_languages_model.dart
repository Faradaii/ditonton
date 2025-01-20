import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/spoken_languages.dart';

class SpokenLanguagesModel extends Equatable {
  SpokenLanguagesModel({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });

  final String englishName;
  final String iso_639_1;
  final String name;

  factory SpokenLanguagesModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguagesModel(
        englishName: json['english_name'],
        iso_639_1: json['iso_639_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['english_name'] = englishName;
    _data['iso_639_1'] = iso_639_1;
    _data['name'] = name;
    return _data;
  }

  SpokenLanguages toEntity() => SpokenLanguages(
        englishName: this.englishName,
        iso6391: this.iso_639_1,
        name: this.name,
      );

  @override
  List<Object?> get props => [englishName, iso_639_1, name];
}
