import 'package:equatable/equatable.dart';

class SpokenLanguagesModel extends Equatable {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguagesModel({required this.englishName, required this.iso6391, required this.name});

  @override
  List<Object?> get props => [
    englishName,
    iso6391,
    name
  ];
}