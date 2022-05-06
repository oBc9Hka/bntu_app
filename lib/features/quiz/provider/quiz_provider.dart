import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  final QuizRepository quizRepository;

  QuizProvider({required this.quizRepository});

  List<QuizModel> quizList = [];
  bool isLoading = false;

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

  Future<void> addQuiz({
    required String quizName,
    required QuizTypes quizType,
  }) async {
    await quizRepository.addQuiz(
      quiz: QuizModel(
          docId: '',
          quizName: quizName,
          quizType: quizType,
          questions: [],
          isVisible: false),
    );
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
}
