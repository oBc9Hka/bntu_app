import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/coeff_result_model.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/domain/models/result_model.dart';
import 'package:bntu_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/question__types.dart';

class QuizProvider with ChangeNotifier {
  final QuizRepository quizRepository;

  QuizProvider({required this.quizRepository});

  List<QuizModel> quizList = [];
  bool isLoading = false;

  QuizModel? activeQuiz;

  QuizModel? quizInEdit;
  QuizModel? quizInEditInitState;

  QuestionModel? questionInEdit;
  int? questionInEditIndex;

  void setQuizInEdit(QuizModel quizModel) {
    quizInEdit = quizModel;
    quizInEditInitState = quizInEdit!.copyWith(
      questions: quizInEdit!.questions,
    );
    notifyListeners();
  }

  bool haveChanges() {
    if (quizInEdit == quizInEditInitState) {
      return false;
    }
    return true;
  }

  Future<void> getActiveQuiz({required String docId}) async {
    await getQuizList();
    activeQuiz = quizList.firstWhere((element) => element.docId == docId);
    notifyListeners();
  }

  void setNewQuizInEdit() {
    quizInEdit = QuizModel(
      docId: '',
      quizName: '',
      quizType: QuizTypes.single_coeff,
      questions: [],
      coefficients: [],
      coeffResults: [],
      needPrintResults: false,
      isVisible: false,
    );
    quizInEditInitState = quizInEdit!.copyWith();
    notifyListeners();
  }

  void setQuestionInEdit(int index) {
    questionInEditIndex = index;
    questionInEdit = quizInEdit!.questions.elementAt(index);

    notifyListeners();
  }

  void clearQuizModel() {
    quizInEdit = null;
    quizInEditInitState = null;
    notifyListeners();
  }

  Future<void> getQuizList() async {
    isLoading = true;
    quizList = await quizRepository.getQuizList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addQuiz() async {
    await quizRepository.addQuiz(
      quiz: QuizModel(
        docId: '',
        quizName: quizInEdit!.quizName,
        quizType: quizInEdit!.quizType,
        questions: [],
        coefficients: quizInEdit!.coefficients,
        coeffResults: quizInEdit!.coeffResults,
        isVisible: false,
        needPrintResults: false,
      ),
    );
    notifyListeners();
    await getQuizList();
  }

  Future<void> addCoeff({required String coeff}) async {
    var list = quizInEdit!.coefficients.map((e) => e).toList();
    list.add(coeff);
    quizInEdit = quizInEdit!.copyWith(coefficients: list);
    notifyListeners();
  }

  Future<void> removeCoeff({required int index}) async {
    var list = quizInEdit!.coefficients.map((e) => e).toList();
    list.removeAt(index);
    quizInEdit = quizInEdit!.copyWith(coefficients: list);
    notifyListeners();
  }

  Future<void> changeNeedPrintResults({required bool value}) async {
    quizInEdit = quizInEdit!.copyWith(
      needPrintResults: value,
      coeffResults: quizInEdit!.coefficients
          .map((e) => CoeffResult(name: e, results: []))
          .toList(),
    );
    notifyListeners();
  }

  Future<void> coeffResultAddNew({required int coeffIndex}) async {
    final cList = quizInEdit!.coeffResults
        .map(
          (e) => CoeffResult(name: e.name, results: e.results),
        )
        .toList();
    final list = quizInEdit!.coeffResults[coeffIndex].results
        .map(
          (e) => Result(
            speciality: e.speciality,
            faculty: e.faculty,
          ),
        )
        .toList();

    list.add(
      Result(speciality: '', faculty: ''),
    );

    cList[coeffIndex] = cList[coeffIndex].copyWith(results: list);

    quizInEdit = quizInEdit!.copyWith(coeffResults: cList);
    notifyListeners();
  }

  Future<void> coeffResultRemove({
    required int coeffIndex,
    required int resultIndex,
  }) async {
    final cList = quizInEdit!.coeffResults
        .map(
          (e) => CoeffResult(name: e.name, results: e.results),
        )
        .toList();
    final list = quizInEdit!.coeffResults[coeffIndex].results
        .map(
          (e) => Result(
            speciality: e.speciality,
            faculty: e.faculty,
          ),
        )
        .toList();
    list.removeAt(resultIndex);

    cList[coeffIndex] = cList[coeffIndex].copyWith(results: list);

    quizInEdit = quizInEdit!.copyWith(coeffResults: cList);
    notifyListeners();
  }

  Future<void> coeffResultChangeSpeciality({
    required int coeffIndex,
    required int resultIndex,
    required String value,
  }) async {
    final cList = quizInEdit!.coeffResults
        .map(
          (e) => CoeffResult(name: e.name, results: e.results),
        )
        .toList();
    final list = quizInEdit!.coeffResults[coeffIndex].results
        .map(
          (e) => Result(
            speciality: e.speciality,
            faculty: e.faculty,
          ),
        )
        .toList();
    list[resultIndex] = list[resultIndex].copyWith(speciality: value);
    cList[coeffIndex] = cList[coeffIndex].copyWith(results: list);
    quizInEdit = quizInEdit!.copyWith(coeffResults: cList);
    notifyListeners();
  }

  Future<void> coeffResultChangeFaculty({
    required int coeffIndex,
    required int resultIndex,
    required String value,
  }) async {
    final cList = quizInEdit!.coeffResults
        .map(
          (e) => CoeffResult(name: e.name, results: e.results),
        )
        .toList();
    final list = quizInEdit!.coeffResults[coeffIndex].results
        .map(
          (e) => Result(
            speciality: e.speciality,
            faculty: e.faculty,
          ),
        )
        .toList();
    list[resultIndex] = list[resultIndex].copyWith(faculty: value);
    cList[coeffIndex] = cList[coeffIndex].copyWith(results: list);
    quizInEdit = quizInEdit!.copyWith(coeffResults: cList);
    notifyListeners();
  }

  Future<void> editQuiz({required QuizModel quiz}) async {
    await quizRepository.editQuiz(quiz: quiz);
    await getQuizList();
    notifyListeners();
  }

  Future<void> editQuestion() async {
    final list = quizInEdit!.questions
        .map(
          (e) => QuestionModel(
            question: e.question,
            questionType: e.questionType,
            answers: e.answers
                .map(
                  (e) => e.copyWith(),
                )
                .toList(),
          ),
        )
        .toList();
    list[questionInEditIndex!] = questionInEdit!;
    quizInEdit = quizInEdit!.copyWith(questions: list);
    notifyListeners();
  }

  Future<void> removeQuestion() async {
    final list = quizInEdit!.questions
        .map((e) => QuestionModel(
            question: e.question,
            questionType: e.questionType,
            answers: e.answers))
        .toList();
    list.removeAt(questionInEditIndex!);
    quizInEdit = quizInEdit!.copyWith(questions: list);
    notifyListeners();
  }

  Future<void> addQuestion() async {
    final list = quizInEdit!.questions
        .map((e) => QuestionModel(
            question: e.question,
            questionType: e.questionType,
            answers: e.answers))
        .toList();
    list.add(questionInEdit!);
    quizInEdit = quizInEdit!.copyWith(questions: list);
    notifyListeners();
  }

  Future<void> reorderQuestions(int oldIndex, int newIndex) async {
    final list = quizInEdit!.questions
        .map((e) => QuestionModel(
            question: e.question,
            questionType: e.questionType,
            answers: e.answers))
        .toList();
    final row = list.removeAt(oldIndex);
    list.insert(newIndex, row);

    quizInEdit = quizInEdit!.copyWith(questions: list);

    notifyListeners();
  }

  Future<void> editAnswersCount() async {
    questionInEdit = questionInEdit!.copyWith(
      questionType: questionInEdit!.questionType == QuestionTypes.single_answer
          ? QuestionTypes.multiple_answers
          : QuestionTypes.single_answer,
    );
    notifyListeners();
  }
}
