import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/production_countries_model.dart';

void main() {
  group('ProductionCountriesModel toJson', () {
    const mockModel = ProductionCountriesModel(
      name: 'USA',
      iso_3166_1: 'US',
    );

    const expectedJson = {
      'name': 'USA',
      'iso_3166_1': 'US',
    };

    test('toJson should return a valid JSON map', () {
      // Act
      final result = mockModel.toJson();

      // Assert
      expect(result, expectedJson);
    });
  });
}
