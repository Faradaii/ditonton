import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/utils.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_card_test.mocks.dart';

@GenerateMocks([NavigatorObserver])
void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  final tTvSeries = TvSeries(
    adult: true,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview tv",
    popularity: 1.0,
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    name: "name tv",
    voteAverage: 1.0,
    voteCount: 1,
  );

  testWidgets('should display tv series name, overview, poster etc',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvCard(tTvSeries),
        ),
      ),
    );

    // Assert
    expect(find.text('name tv'), findsOneWidget);
    expect(find.text('overview tv'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(Icons.error), findsNothing);
  });

  testWidgets('should navigate to TvDetailPage on tap',
      (WidgetTester tester) async {
    // Arrange
    when(mockObserver.navigator).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockObserver],
        onGenerateRoute: (settings) {
          if (settings.name == routeDetailTv) {
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Text('Tv Series ID: $id'),
              ),
            );
          }
          return null;
        },
        home: Scaffold(
          body: TvCard(tTvSeries),
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
    expect(find.text('Tv Series ID: 1'), findsOneWidget);
  });
}
