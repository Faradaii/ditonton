import 'package:movie/data/models/movie_table.dart';
import 'package:test/test.dart';

void main() {
  group('MovieTable toJson', () {
    test('should return a valid JSON map containing proper data', () {
      // Arrange
      const movieTable = MovieTable(
        id: 1,
        title: 'Spider-Man',
        posterPath: '/poster_path.jpg',
        overview: 'A superhero story',
      );

      // Act
      final result = movieTable.toJson();

      // Assert
      expect(result, {
        'id': 1,
        'title': 'Spider-Man',
        'posterPath': '/poster_path.jpg',
        'overview': 'A superhero story',
      });
    });
  });
}
