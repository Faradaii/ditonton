import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/spoken_languages_model.dart';

void main() {
  group('SpokenLanguagesModel toJson', () {
    const mockModel = SpokenLanguagesModel(
      englishName: 'English',
      iso_639_1: 'en',
      name: 'English',
    );

    const expectedJson = {
      'english_name': 'English',
      'iso_639_1': 'en',
      'name': 'English',
    };

    test('toJson should return a valid JSON map', () {
      // Act
      final result = mockModel.toJson();

      // Assert
      expect(result, expectedJson);
    });
  });
}
