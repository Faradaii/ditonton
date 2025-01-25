import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/genres.dart';

class GenresModel extends Equatable {
  const GenresModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String? name;

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  Genres toEntity() => Genres(id: id, name: name);

  @override
  List<Object?> get props => [id, name];
}
