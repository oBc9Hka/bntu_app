// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuestionModel {
  String get question => throw _privateConstructorUsedError;
  QuestionTypes get questionType => throw _privateConstructorUsedError;
  List<Answer> get answers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionModelCopyWith<QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionModelCopyWith<$Res> {
  factory $QuestionModelCopyWith(
          QuestionModel value, $Res Function(QuestionModel) then) =
      _$QuestionModelCopyWithImpl<$Res>;
  $Res call(
      {String question, QuestionTypes questionType, List<Answer> answers});
}

/// @nodoc
class _$QuestionModelCopyWithImpl<$Res>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._value, this._then);

  final QuestionModel _value;
  // ignore: unused_field
  final $Res Function(QuestionModel) _then;

  @override
  $Res call({
    Object? question = freezed,
    Object? questionType = freezed,
    Object? answers = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      questionType: questionType == freezed
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as QuestionTypes,
      answers: answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ));
  }
}

/// @nodoc
abstract class _$QuestionModelCopyWith<$Res>
    implements $QuestionModelCopyWith<$Res> {
  factory _$QuestionModelCopyWith(
          _QuestionModel value, $Res Function(_QuestionModel) then) =
      __$QuestionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String question, QuestionTypes questionType, List<Answer> answers});
}

/// @nodoc
class __$QuestionModelCopyWithImpl<$Res>
    extends _$QuestionModelCopyWithImpl<$Res>
    implements _$QuestionModelCopyWith<$Res> {
  __$QuestionModelCopyWithImpl(
      _QuestionModel _value, $Res Function(_QuestionModel) _then)
      : super(_value, (v) => _then(v as _QuestionModel));

  @override
  _QuestionModel get _value => super._value as _QuestionModel;

  @override
  $Res call({
    Object? question = freezed,
    Object? questionType = freezed,
    Object? answers = freezed,
  }) {
    return _then(_QuestionModel(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      questionType: questionType == freezed
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as QuestionTypes,
      answers: answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ));
  }
}

/// @nodoc

class _$_QuestionModel implements _QuestionModel {
  const _$_QuestionModel(
      {required this.question,
      required this.questionType,
      required final List<Answer> answers})
      : _answers = answers;

  @override
  final String question;
  @override
  final QuestionTypes questionType;
  final List<Answer> _answers;
  @override
  List<Answer> get answers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'QuestionModel(question: $question, questionType: $questionType, answers: $answers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuestionModel &&
            const DeepCollectionEquality().equals(other.question, question) &&
            const DeepCollectionEquality()
                .equals(other.questionType, questionType) &&
            const DeepCollectionEquality().equals(other.answers, answers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(question),
      const DeepCollectionEquality().hash(questionType),
      const DeepCollectionEquality().hash(answers));

  @JsonKey(ignore: true)
  @override
  _$QuestionModelCopyWith<_QuestionModel> get copyWith =>
      __$QuestionModelCopyWithImpl<_QuestionModel>(this, _$identity);
}

abstract class _QuestionModel implements QuestionModel {
  const factory _QuestionModel(
      {required final String question,
      required final QuestionTypes questionType,
      required final List<Answer> answers}) = _$_QuestionModel;

  @override
  String get question => throw _privateConstructorUsedError;
  @override
  QuestionTypes get questionType => throw _privateConstructorUsedError;
  @override
  List<Answer> get answers => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$QuestionModelCopyWith<_QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
