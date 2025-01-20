import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/production_companies.dart';

class ProductionCompaniesModel extends Equatable {
  ProductionCompaniesModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  late final int id;
  late final String logoPath;
  late final String name;
  late final String originCountry;

  ProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo_path'] = logoPath;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    return _data;
  }

  ProductionCompanies toEntity() => ProductionCompanies(
      id: this.id,
      logoPath: this.logoPath,
      name: this.name,
      originCountry: this.originCountry);

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
