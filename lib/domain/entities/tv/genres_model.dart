import 'package:equatable/equatable.dart';

class GenresModel extends Equatable {
  int? id;
  String? name;

  GenresModel({required this.id, required this.name});

  @override
  List<Object?> get props => [
    id,
    name
  ];
}