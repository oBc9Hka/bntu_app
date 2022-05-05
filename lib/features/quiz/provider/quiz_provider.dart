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

  Future<void> editQuestion() async {
    quizInEdit!.questions.elementAt(questionInEditIndex!).answers =
        questionInEdit!.answers;
    quizInEdit!.questions.elementAt(questionInEditIndex!).question =
        questionInEdit!.question;
    quizInEdit!.questions.elementAt(questionInEditIndex!).questionType =
        questionInEdit!.questionType;
    notifyListeners();
  }

  Future<void> removeQuestion() async {
    quizInEdit!.questions.removeAt(questionInEditIndex!);
    notifyListeners();
  }

  Future<void> addQuestion(QuestionModel questionModel) async {
    quizInEdit!.questions.add(questionModel);
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
