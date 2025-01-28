import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/production_companies_model.dart';

void main() {
  group('ProductionCompaniesModel toJson', () {
    const mockModel = ProductionCompaniesModel(
      id: 1,
      logoPath: '/logo_path.jpg',
      name: 'Production Company',
      originCountry: 'US',
    );

    const expectedJson = {
      'id': 1,
      'logo_path': '/logo_path.jpg',
      'name': 'Production Company',
      'origin_country': 'US',
    };

    test('toJson should return a valid JSON map', () {
      // Act
      final result = mockModel.toJson();

      // Assert
      expect(result, expectedJson);
    });
  });
}
