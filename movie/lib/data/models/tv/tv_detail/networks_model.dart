import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/networks.dart';

class NetworksModel extends Equatable {
  const NetworksModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
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
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }

  Networks toEntity() => Networks(
      id: id, logoPath: logoPath, name: name, originCountry: originCountry);

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
