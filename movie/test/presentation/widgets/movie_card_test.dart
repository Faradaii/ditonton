import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/utils.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_card_test.mocks.dart';

@GenerateMocks([NavigatorObserver])
void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview movie',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title movie',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('should display movie title, overview, poster etc',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(tMovie),
        ),
      ),
    );

    // Assert
    expect(find.text('title movie'), findsOneWidget);
    expect(find.text('overview movie'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(Icons.error), findsNothing);
  });

  testWidgets('should navigate to MovieDetailPage on tap',
      (WidgetTester tester) async {
    // Arrange
    when(mockObserver.navigator).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockObserver],
        onGenerateRoute: (settings) {
          if (settings.name == routeDetailMovie) {
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Text('Movie ID: $id'),
              ),
            );
          }
          return null;
        },
        home: Scaffold(
          body: MovieCard(tMovie),
        ),
      ),
    );

    // Verify the initial state
    verify(mockObserver.didPush(any, any)).called(1);

    // Act
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Assert
    verify(mockObserver.didPush(any, any)).called(1);
    expect(find.text('Movie ID: 1'), findsOneWidget);
  });
}
