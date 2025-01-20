import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/production_countries.dart';

class ProductionCountriesModel extends Equatable {
  ProductionCountriesModel({
    required this.iso_3166_1,
    required this.name,
  });

  final String iso_3166_1;
  final String name;

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountriesModel(
        iso_3166_1: json['iso_3166_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iso_3166_1'] = iso_3166_1;
    _data['name'] = name;
    return _data;
  }

  ProductionCountries toEntity() => ProductionCountries(
        iso31661: this.iso_3166_1,
        name: this.name,
      );

  @override
  List<Object?> get props => [iso_3166_1, name];
}
