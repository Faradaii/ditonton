import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/production_countries.dart';

class ProductionCountriesModel extends Equatable {
  const ProductionCountriesModel({
    required this.iso_3166_1,
    required this.name,
  });

  final String? iso_3166_1;
  final String? name;

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountriesModel(
        iso_3166_1: json['iso_3166_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_3166_1'] = iso_3166_1;
    data['name'] = name;
    return data;
  }

  ProductionCountries toEntity() => ProductionCountries(
        iso31661: iso_3166_1,
        name: name,
      );

  @override
  List<Object?> get props => [iso_3166_1, name];
}
