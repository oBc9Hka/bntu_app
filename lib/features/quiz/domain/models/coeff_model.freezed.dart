// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'coeff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Coeff {
  String get key => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoeffCopyWith<Coeff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoeffCopyWith<$Res> {
  factory $CoeffCopyWith(Coeff value, $Res Function(Coeff) then) =
      _$CoeffCopyWithImpl<$Res>;
  $Res call({String key, int weight});
}

/// @nodoc
class _$CoeffCopyWithImpl<$Res> implements $CoeffCopyWith<$Res> {
  _$CoeffCopyWithImpl(this._value, this._then);

  final Coeff _value;
  // ignore: unused_field
  final $Res Function(Coeff) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? weight = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CoeffCopyWith<$Res> implements $CoeffCopyWith<$Res> {
  factory _$CoeffCopyWith(_Coeff value, $Res Function(_Coeff) then) =
      __$CoeffCopyWithImpl<$Res>;
  @override
  $Res call({String key, int weight});
}

/// @nodoc
class __$CoeffCopyWithImpl<$Res> extends _$CoeffCopyWithImpl<$Res>
    implements _$CoeffCopyWith<$Res> {
  __$CoeffCopyWithImpl(_Coeff _value, $Res Function(_Coeff) _then)
      : super(_value, (v) => _then(v as _Coeff));

  @override
  _Coeff get _value => super._value as _Coeff;

  @override
  $Res call({
    Object? key = freezed,
    Object? weight = freezed,
  }) {
    return _then(_Coeff(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Coeff implements _Coeff {
  const _$_Coeff({required this.key, required this.weight});

  @override
  final String key;
  @override
  final int weight;

  @override
  String toString() {
    return 'Coeff(key: $key, weight: $weight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Coeff &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.weight, weight));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(weight));

  @JsonKey(ignore: true)
  @override
  _$CoeffCopyWith<_Coeff> get copyWith =>
      __$CoeffCopyWithImpl<_Coeff>(this, _$identity);
}

abstract class _Coeff implements Coeff {
  const factory _Coeff({required final String key, required final int weight}) =
      _$_Coeff;

  @override
  String get key => throw _privateConstructorUsedError;
  @override
  int get weight => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CoeffCopyWith<_Coeff> get copyWith => throw _privateConstructorUsedError;
}
