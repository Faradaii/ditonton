import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/networks.dart';

class NetworksModel extends Equatable {
  NetworksModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  factory NetworksModel.fromJson(Map<String, dynamic> json) => NetworksModel(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo_path'] = logoPath;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    return _data;
  }

  Networks toEntity() => Networks(
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
