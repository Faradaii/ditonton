import 'package:equatable/equatable.dart';

class ProductionCompaniesModel extends Equatable {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompaniesModel({required this.id, required this.logoPath, required this.name, required this.originCountry});

  @override
  List<Object?> get props => [
    id,
    logoPath,
    name,
    originCountry
  ];
}