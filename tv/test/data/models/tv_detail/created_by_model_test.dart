import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/created_by_model.dart';

void main() {
  group('CreatedByModel toJson Test', () {
    test('should return a JSON map with proper data', () {
      // Arrange
      const createdByModel = CreatedByModel(
        id: 1,
        creditId: '1234',
        name: 'John Doe',
        originalName: 'Johnathan Doe',
        gender: 1,
        profilePath: '/profile.jpg',
      );

      // Act
      final result = createdByModel.toJson();

      // Assert
      expect(result, {
        'id': 1,
        'credit_id': '1234',
        'name': 'John Doe',
        'original_name': 'Johnathan Doe',
        'gender': 1,
        'profile_path': '/profile.jpg',
      });
    });
  });
}
