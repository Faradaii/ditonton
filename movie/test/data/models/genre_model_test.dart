import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';

void main() {
  test('toJson', () {
    final tGenreModel = GenreModel(id: 1, name: 'Action');

    final result = tGenreModel.toJson();

    expect(result, {'id': 1, 'name': 'Action'});
  });
}
