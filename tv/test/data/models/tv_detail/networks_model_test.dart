import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv/tv_detail/networks_model.dart';

void main() {
  group('NetworksModel toJson Test', () {
    test('should return a JSON map with proper data', () {
      // Arrange
      const networksModel = NetworksModel(
        id: 101,
        logoPath: '/logo_path.png',
        name: 'Network Name',
        originCountry: 'US',
      );

      // Act
      final result = networksModel.toJson();

      // Assert
      expect(result, {
        'id': 101,
        'logo_path': '/logo_path.png',
        'name': 'Network Name',
        'origin_country': 'US',
      });
    });
  });
}
