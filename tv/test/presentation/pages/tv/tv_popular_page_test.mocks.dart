// Mocks generated by Mockito 5.4.5 from annotations
// in tv/test/presentation/pages/tv/tv_popular_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:core/common/state_enum.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:tv/domain/entities/tv/tv.dart' as _i5;
import 'package:tv/domain/usecases/tv/get_popular_tv.dart' as _i2;
import 'package:tv/presentation/provider/tv/tv_popular_notifier.dart' as _i3;

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

class _FakeGetPopularTv_0 extends _i1.SmartFake implements _i2.GetPopularTv {
  _FakeGetPopularTv_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [TvPopularNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvPopularNotifier extends _i1.Mock implements _i3.TvPopularNotifier {
  MockTvPopularNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularTv get getPopularTv =>
      (super.noSuchMethod(
            Invocation.getter(#getPopularTv),
            returnValue: _FakeGetPopularTv_0(
              this,
              Invocation.getter(#getPopularTv),
            ),
          )
          as _i2.GetPopularTv);

  @override
  _i4.RequestState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _i4.RequestState.empty,
          )
          as _i4.RequestState);

  @override
  List<_i5.TvSeries> get tv =>
      (super.noSuchMethod(Invocation.getter(#tv), returnValue: <_i5.TvSeries>[])
          as List<_i5.TvSeries>);

  @override
  String get message =>
      (super.noSuchMethod(
            Invocation.getter(#message),
            returnValue: _i6.dummyValue<String>(
              this,
              Invocation.getter(#message),
            ),
          )
          as String);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i7.Future<void> fetchPopularTv() =>
      (super.noSuchMethod(
            Invocation.method(#fetchPopularTv, []),
            returnValue: _i7.Future<void>.value(),
            returnValueForMissingStub: _i7.Future<void>.value(),
          )
          as _i7.Future<void>);

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
