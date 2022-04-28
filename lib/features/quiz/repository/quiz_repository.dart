import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:bntu_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirestoreRepository extends QuizRepository {
  final dbRef = FirebaseFirestore.instance.collection('quizV2');

  @override
  Future<bool> addQuiz({required QuizModel quiz}) async {
    await dbRef.add({
      'quizName': quiz.quizName,
      'quizType': quiz.quizType.asString,
      'questions': [],
      'isVisible': false,
    });

    return true;
  }

  @override
  Future<bool> deleteQuiz({required String quizName}) {
    // TODO: implement deleteQuiz
    throw UnimplementedError();
  }

  @override
  Future<bool> editQuiz({required QuizModel quiz}) {
    // TODO: implement editQuiz
    throw UnimplementedError();
  }

  @override
  Future<List<QuestionModel>> getQuestionsList({required String collection}) {
    // TODO: implement getQuestionsList
    throw UnimplementedError();
  }

  @override
  Future<List<QuizModel>> getQuizList() async {
    final response = await dbRef.get();

    return response.docs
        .map(
          (e) => QuizModel(
            docId: e.id,
            quizName: e['quizName'],
            quizType: quizTypeFromString(e['quizType']),
            questions: [],
            isVisible: e['isVisible'],
          ),
        )
        .toList();
  }
}
