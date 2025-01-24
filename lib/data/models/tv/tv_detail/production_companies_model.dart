import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/production_companies.dart';

class ProductionCompaniesModel extends Equatable {
  const ProductionCompaniesModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompaniesModel(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }

  ProductionCompanies toEntity() => ProductionCompanies(
      id: id, logoPath: logoPath, name: name, originCountry: originCountry);

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
