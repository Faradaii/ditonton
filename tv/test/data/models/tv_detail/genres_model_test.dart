import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/genres_model.dart';

void main() {
  group('GenresModel toJson Test', () {
    test('should return a JSON map with proper data', () {
      // Arrange
      const genresModel = GenresModel(
        id: 1,
        name: 'Drama',
      );

      // Act
      final result = genresModel.toJson();

      // Assert
      expect(result, {
        'id': 1,
        'name': 'Drama',
      });
    });
  });
}
