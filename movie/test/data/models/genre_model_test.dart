import 'package:movie/data/models/genre_model.dart';
import 'package:test/test.dart';

void main() {
  test('toJson', () {
    final tGenreModel = GenreModel(id: 1, name: 'Action');

    final result = tGenreModel.toJson();

    expect(result, {'id': 1, 'name': 'Action'});
  });
}