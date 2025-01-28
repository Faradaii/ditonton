import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/db/database_tv.dart';
import 'package:tv/data/models/tv/tv_table.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late DatabaseTv databaseTv;
  late MockDatabaseHelper mockDatabaseHelper;

  setUpAll(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    databaseTv = DatabaseTv(databaseHelper: mockDatabaseHelper);
  });

  group('DatabaseTv', () {
    test('should insert a tv into the watchlist', () async {
      // Arrange
      final tv = TvTable(
        id: 1,
        name: 'Test Tv',
        overview: 'Overview',
        posterPath: '/path.jpg',
      );

      when(databaseTv.insertWatchlistTv(tv)).thenAnswer((_) async => 1);

      // Act
      final result = await databaseTv.insertWatchlistTv(tv);

      // Assert
      expect(result, 1);
      verify(databaseTv.insertWatchlistTv(tv)).called(1);
    });

    test('should remove a tv from the watchlist', () async {
      // Arrange
      final tv = TvTable(
        id: 1,
        name: 'Test Tv',
        overview: 'Overview',
        posterPath: '/path.jpg',
      );

      when(databaseTv.removeWatchlistTv(tv)).thenAnswer((_) async => 1);

      // Act
      final result = await databaseTv.removeWatchlistTv(tv);

      // Assert
      expect(result, 1);
      verify(databaseTv.removeWatchlistTv(tv)).called(1);
    });

    test('should get a tv by ID', () async {
      // Arrange
      const id = 1;
      final Map<String, dynamic> tvData = {
        'id': id,
        'name': 'Test Tv',
        'overview': 'Overview',
        'posterPath': '/path.jpg',
      };

      when(databaseTv.getTvById(id)).thenAnswer((_) async => [tvData]);

      // Act
      final result = await databaseTv.getTvById(id);

      // Assert
      expect(result!.first, tvData);
      verify(databaseTv.getTvById(id)).called(1);
    });

    test('should return null if no tv is found by ID', () async {
      // Arrange
      const id = 2;

      when(databaseTv.getTvById(id)).thenAnswer((_) async => null);

      // Act
      final result = await databaseTv.getTvById(id);

      // Assert
      expect(result, null);
      verify(databaseTv.getTvById(id)).called(1);
    });

    test('should get all tvList from the watchlist', () async {
      // Arrange
      final tvListData = [
        {
          'id': 1,
          'name': 'Test Tv 1',
          'overview': 'Overview 1',
          'posterPath': '/path1.jpg',
        },
        {
          'id': 2,
          'name': 'Test Tv 2',
          'overview': 'Overview 2',
          'posterPath': '/path2.jpg',
        },
      ];

      when(databaseTv.getWatchlistTv()).thenAnswer((_) async => tvListData);

      // Act
      final result = await databaseTv.getWatchlistTv();

      // Assert
      expect(result, tvListData);
      verify(databaseTv.getWatchlistTv()).called(1);
    });
  });
}
