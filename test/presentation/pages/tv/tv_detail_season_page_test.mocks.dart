// Mocks generated by Mockito 5.4.5 from annotations
// in ditonton/test/presentation/pages/tv/tv_detail_season_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:ditonton/common/state_enum.dart' as _i5;
import 'package:ditonton/domain/entities/tv/season/season_detail.dart' as _i3;
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart' as _i2;
import 'package:ditonton/presentation/provider/tv/tv_detail_season_notifier.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvDetailSeason_0 extends _i1.SmartFake
    implements _i2.GetTvDetailSeason {
  _FakeGetTvDetailSeason_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSeason_1 extends _i1.SmartFake implements _i3.Season {
  _FakeSeason_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvDetailSeasonNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailSeasonNotifier extends _i1.Mock
    implements _i4.TvDetailSeasonNotifier {
  MockTvDetailSeasonNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetailSeason get getTvDetailSeason => (super.noSuchMethod(
        Invocation.getter(#getTvDetailSeason),
        returnValue: _FakeGetTvDetailSeason_0(
          this,
          Invocation.getter(#getTvDetailSeason),
        ),
      ) as _i2.GetTvDetailSeason);

  @override
  _i3.Season get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSeason_1(this, Invocation.getter(#season)),
      ) as _i3.Season);

  @override
  _i5.RequestState get seasonState => (super.noSuchMethod(
        Invocation.getter(#seasonState),
        returnValue: _i5.RequestState.Empty,
      ) as _i5.RequestState);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i7.Future<void> fetchTvDetailSeason(int? id, int? seasonNumber) =>
      (super.noSuchMethod(
        Invocation.method(#fetchTvDetailSeason, [id, seasonNumber]),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(#addListener, [listener]),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(#removeListener, [listener]),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(#dispose, []),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(#notifyListeners, []),
        returnValueForMissingStub: null,
      );
}
