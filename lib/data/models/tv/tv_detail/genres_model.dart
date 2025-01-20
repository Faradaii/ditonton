import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/genres.dart';

class GenresModel extends Equatable {
  GenresModel({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  GenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }

  Genres toEntity() => Genres(id: this.id, name: this.name);

  @override
  List<Object?> get props => [id, name];
}
