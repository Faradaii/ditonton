import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/networks.dart';

class NetworksModel extends Equatable {
  NetworksModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  late final int id;
  late final String logoPath;
  late final String name;
  late final String originCountry;

  NetworksModel.fromJson(Map<String, dynamic> json) {
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
