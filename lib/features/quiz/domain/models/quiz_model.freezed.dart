// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quiz_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizModel {
  String get docId => throw _privateConstructorUsedError;
  String get quizName => throw _privateConstructorUsedError;
  QuizTypes get quizType => throw _privateConstructorUsedError;
  List<QuestionModel> get questions => throw _privateConstructorUsedError;
  List<String> get coefficients => throw _privateConstructorUsedError;
  List<dynamic> get coeffResults => throw _privateConstructorUsedError;
  bool get needPrintResults => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizModelCopyWith<QuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizModelCopyWith<$Res> {
  factory $QuizModelCopyWith(QuizModel value, $Res Function(QuizModel) then) =
      _$QuizModelCopyWithImpl<$Res>;
  $Res call(
      {String docId,
      String quizName,
      QuizTypes quizType,
      List<QuestionModel> questions,
      List<String> coefficients,
      List<dynamic> coeffResults,
      bool needPrintResults,
      bool isVisible});
}

/// @nodoc
class _$QuizModelCopyWithImpl<$Res> implements $QuizModelCopyWith<$Res> {
  _$QuizModelCopyWithImpl(this._value, this._then);

  final QuizModel _value;
  // ignore: unused_field
  final $Res Function(QuizModel) _then;

  @override
  $Res call({
    Object? docId = freezed,
    Object? quizName = freezed,
    Object? quizType = freezed,
    Object? questions = freezed,
    Object? coefficients = freezed,
    Object? coeffResults = freezed,
    Object? needPrintResults = freezed,
    Object? isVisible = freezed,
  }) {
    return _then(_value.copyWith(
      docId: docId == freezed
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      quizName: quizName == freezed
          ? _value.quizName
          : quizName // ignore: cast_nullable_to_non_nullable
              as String,
      quizType: quizType == freezed
          ? _value.quizType
          : quizType // ignore: cast_nullable_to_non_nullable
              as QuizTypes,
      questions: questions == freezed
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
      coefficients: coefficients == freezed
          ? _value.coefficients
          : coefficients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coeffResults: coeffResults == freezed
          ? _value.coeffResults
          : coeffResults // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      needPrintResults: needPrintResults == freezed
          ? _value.needPrintResults
          : needPrintResults // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: isVisible == freezed
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$QuizModelCopyWith<$Res> implements $QuizModelCopyWith<$Res> {
  factory _$QuizModelCopyWith(
          _QuizModel value, $Res Function(_QuizModel) then) =
      __$QuizModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String docId,
      String quizName,
      QuizTypes quizType,
      List<QuestionModel> questions,
      List<String> coefficients,
      List<dynamic> coeffResults,
      bool needPrintResults,
      bool isVisible});
}

/// @nodoc
class __$QuizModelCopyWithImpl<$Res> extends _$QuizModelCopyWithImpl<$Res>
    implements _$QuizModelCopyWith<$Res> {
  __$QuizModelCopyWithImpl(_QuizModel _value, $Res Function(_QuizModel) _then)
      : super(_value, (v) => _then(v as _QuizModel));

  @override
  _QuizModel get _value => super._value as _QuizModel;

  @override
  $Res call({
    Object? docId = freezed,
    Object? quizName = freezed,
    Object? quizType = freezed,
    Object? questions = freezed,
    Object? coefficients = freezed,
    Object? coeffResults = freezed,
    Object? needPrintResults = freezed,
    Object? isVisible = freezed,
  }) {
    return _then(_QuizModel(
      docId: docId == freezed
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      quizName: quizName == freezed
          ? _value.quizName
          : quizName // ignore: cast_nullable_to_non_nullable
              as String,
      quizType: quizType == freezed
          ? _value.quizType
          : quizType // ignore: cast_nullable_to_non_nullable
              as QuizTypes,
      questions: questions == freezed
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
      coefficients: coefficients == freezed
          ? _value.coefficients
          : coefficients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coeffResults: coeffResults == freezed
          ? _value.coeffResults
          : coeffResults // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      needPrintResults: needPrintResults == freezed
          ? _value.needPrintResults
          : needPrintResults // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: isVisible == freezed
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_QuizModel implements _QuizModel {
  const _$_QuizModel(
      {required this.docId,
      required this.quizName,
      required this.quizType,
      required final List<QuestionModel> questions,
      required final List<String> coefficients,
      required final List<dynamic> coeffResults,
      required this.needPrintResults,
      required this.isVisible})
      : _questions = questions,
        _coefficients = coefficients,
        _coeffResults = coeffResults;

  @override
  final String docId;
  @override
  final String quizName;
  @override
  final QuizTypes quizType;
  final List<QuestionModel> _questions;
  @override
  List<QuestionModel> get questions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final List<String> _coefficients;
  @override
  List<String> get coefficients {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coefficients);
  }

  final List<dynamic> _coeffResults;
  @override
  List<dynamic> get coeffResults {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coeffResults);
  }

  @override
  final bool needPrintResults;
  @override
  final bool isVisible;

  @override
  String toString() {
    return 'QuizModel(docId: $docId, quizName: $quizName, quizType: $quizType, questions: $questions, coefficients: $coefficients, coeffResults: $coeffResults, needPrintResults: $needPrintResults, isVisible: $isVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizModel &&
            const DeepCollectionEquality().equals(other.docId, docId) &&
            const DeepCollectionEquality().equals(other.quizName, quizName) &&
            const DeepCollectionEquality().equals(other.quizType, quizType) &&
            const DeepCollectionEquality().equals(other.questions, questions) &&
            const DeepCollectionEquality()
                .equals(other.coefficients, coefficients) &&
            const DeepCollectionEquality()
                .equals(other.coeffResults, coeffResults) &&
            const DeepCollectionEquality()
                .equals(other.needPrintResults, needPrintResults) &&
            const DeepCollectionEquality().equals(other.isVisible, isVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(docId),
      const DeepCollectionEquality().hash(quizName),
      const DeepCollectionEquality().hash(quizType),
      const DeepCollectionEquality().hash(questions),
      const DeepCollectionEquality().hash(coefficients),
      const DeepCollectionEquality().hash(coeffResults),
      const DeepCollectionEquality().hash(needPrintResults),
      const DeepCollectionEquality().hash(isVisible));

  @JsonKey(ignore: true)
  @override
  _$QuizModelCopyWith<_QuizModel> get copyWith =>
      __$QuizModelCopyWithImpl<_QuizModel>(this, _$identity);
}

abstract class _QuizModel implements QuizModel {
  const factory _QuizModel(
      {required final String docId,
      required final String quizName,
      required final QuizTypes quizType,
      required final List<QuestionModel> questions,
      required final List<String> coefficients,
      required final List<dynamic> coeffResults,
      required final bool needPrintResults,
      required final bool isVisible}) = _$_QuizModel;

  @override
  String get docId => throw _privateConstructorUsedError;
  @override
  String get quizName => throw _privateConstructorUsedError;
  @override
  QuizTypes get quizType => throw _privateConstructorUsedError;
  @override
  List<QuestionModel> get questions => throw _privateConstructorUsedError;
  @override
  List<String> get coefficients => throw _privateConstructorUsedError;
  @override
  List<dynamic> get coeffResults => throw _privateConstructorUsedError;
  @override
  bool get needPrintResults => throw _privateConstructorUsedError;
  @override
  bool get isVisible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$QuizModelCopyWith<_QuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}
