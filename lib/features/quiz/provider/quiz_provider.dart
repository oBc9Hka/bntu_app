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

  void setQuizInEdit(QuizModel quizModel) {
    quizInEdit = quizModel;
    quizInEditInitState = QuizModel(
      docId: quizModel.docId,
      quizName: quizModel.quizName,
      quizType: quizModel.quizType,
      questions: quizModel.questions
          .map(
            (e) => QuestionModel(
              question: e.question,
              questionType: e.questionType,
              answers: e.answers,
            ),
          )
          .toList(),
      isVisible: quizModel.isVisible,
    );
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
    // quizInEdit = quizList.firstWhere((element) => element.docId == quiz.docId);
    notifyListeners();
  }

  Future<void> editQuestions() async {
    notifyListeners();
  }
}
