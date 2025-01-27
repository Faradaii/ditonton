import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/widgets/custom_cached_image.dart';

class MockDefaultCacheManager extends Mock implements DefaultCacheManager {}

void main() {
  testWidgets('render errorWidget', (tester) async {
    final mockCacheManager = MockDefaultCacheManager();

    when(() => mockCacheManager.getImageFile(any())).thenThrow(Exception());

    final widget = MaterialApp(
      home: CustomCachedImage(
        defaultCacheManager: mockCacheManager,
        imageUrl: '',
        placeholder: (ctx, url) => const Text('place holder'),
        errorWidget: (ctx, url, error) => const Icon(Icons.error, key: Key('error'),),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('error')), findsOneWidget);
  });

  testWidgets('render placeholder', (tester) async {
    final mockCacheManager = MockDefaultCacheManager();

    when(() => mockCacheManager.getImageFile(any())).thenThrow(Exception());

    final widget = MaterialApp(
      home: CustomCachedImage(
        defaultCacheManager: mockCacheManager,
        imageUrl: '',
        placeholder: (ctx, url) => const CircularProgressIndicator(key: Key('placeholder'),),
        errorWidget: (ctx, url, error) => const Icon(Icons.error, key: Key('error'),),
      ),
    );

    await tester.pumpWidget(widget);

    expect(find.byKey(Key('placeholder')), findsOneWidget);
  });
}