// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'coeff_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CoeffResult {
  String get name => throw _privateConstructorUsedError;
  List<Result> get results => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoeffResultCopyWith<CoeffResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoeffResultCopyWith<$Res> {
  factory $CoeffResultCopyWith(
          CoeffResult value, $Res Function(CoeffResult) then) =
      _$CoeffResultCopyWithImpl<$Res>;
  $Res call({String name, List<Result> results});
}

/// @nodoc
class _$CoeffResultCopyWithImpl<$Res> implements $CoeffResultCopyWith<$Res> {
  _$CoeffResultCopyWithImpl(this._value, this._then);

  final CoeffResult _value;
  // ignore: unused_field
  final $Res Function(CoeffResult) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Result>,
    ));
  }
}

/// @nodoc
abstract class _$CoeffResultCopyWith<$Res>
    implements $CoeffResultCopyWith<$Res> {
  factory _$CoeffResultCopyWith(
          _CoeffResult value, $Res Function(_CoeffResult) then) =
      __$CoeffResultCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<Result> results});
}

/// @nodoc
class __$CoeffResultCopyWithImpl<$Res> extends _$CoeffResultCopyWithImpl<$Res>
    implements _$CoeffResultCopyWith<$Res> {
  __$CoeffResultCopyWithImpl(
      _CoeffResult _value, $Res Function(_CoeffResult) _then)
      : super(_value, (v) => _then(v as _CoeffResult));

  @override
  _CoeffResult get _value => super._value as _CoeffResult;

  @override
  $Res call({
    Object? name = freezed,
    Object? results = freezed,
  }) {
    return _then(_CoeffResult(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Result>,
    ));
  }
}

/// @nodoc

class _$_CoeffResult implements _CoeffResult {
  const _$_CoeffResult(
      {required this.name, required final List<Result> results})
      : _results = results;

  @override
  final String name;
  final List<Result> _results;
  @override
  List<Result> get results {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CoeffResult(name: $name, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CoeffResult &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(results));

  @JsonKey(ignore: true)
  @override
  _$CoeffResultCopyWith<_CoeffResult> get copyWith =>
      __$CoeffResultCopyWithImpl<_CoeffResult>(this, _$identity);
}

abstract class _CoeffResult implements CoeffResult {
  const factory _CoeffResult(
      {required final String name,
      required final List<Result> results}) = _$_CoeffResult;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<Result> get results => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CoeffResultCopyWith<_CoeffResult> get copyWith =>
      throw _privateConstructorUsedError;
}
