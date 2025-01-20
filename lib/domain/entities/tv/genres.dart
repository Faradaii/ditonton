import 'package:equatable/equatable.dart';

class Genres extends Equatable {
  int? id;
  String? name;

  Genres({required this.id, required this.name});

  @override
  List<Object?> get props => [
    id,
    name
  ];
}